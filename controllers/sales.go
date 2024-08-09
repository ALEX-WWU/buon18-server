package controllers

import (
	"database/sql"
	"fmt"
	"server/models"
	"server/services/sales"
	"server/utils"

	"github.com/gin-gonic/gin"
)

type SalesHandler struct {
	DB                    *sql.DB
	SalesQuotationService *sales.SalesQuotationService
}

func (handler *SalesHandler) Quotations(c *gin.Context) {
	qp := utils.NewQueryParams()
	for _, filter := range models.SalesQuotationAllowFilterFieldsAndOps {
		if validFilter, ok := c.GetQuery(filter); ok {
			qp.AddFilter(fmt.Sprintf(`"sales.quotation".%s=%s`, filter, validFilter))
		}
	}
	for _, sort := range models.SalesQuotationAllowSortFields {
		if validSort, ok := c.GetQuery(fmt.Sprintf("sort-%s", sort)); ok {
			qp.AddOrderBy(fmt.Sprintf(`LOWER("limited_quotations".%s) %s`, sort, validSort))
		}
	}
	for _, pagination := range []string{"offset", "limit"} {
		if validPagination, ok := c.GetQuery(pagination); ok {
			if pagination == "offset" {
				qp.AddOffset(utils.StrToInt(validPagination, 0))
			} else {
				qp.AddLimit(utils.StrToInt(validPagination, 10))
			}
		}
	}

	quotations, total, statusCode, err := handler.SalesQuotationService.Quotations(qp)
	if err != nil {
		c.JSON(statusCode, utils.NewErrorResponse(statusCode, err.Error()))
		return
	}

	c.Header("X-Total-Count", fmt.Sprintf("%d", total))
	c.JSON(200, utils.NewResponse(200, "", gin.H{
		"quotations": quotations,
	}))
}
