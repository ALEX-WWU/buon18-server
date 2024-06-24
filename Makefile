db-create:
	migrate create -dir sql/migrations -ext sql $(name)

db-up:
	migrate -database postgres://postgres:postgres@localhost:5432/demo?sslmode=disable -path sql/migrations up $(number)

db-down:
	migrate -database postgres://postgres:postgres@localhost:5432/demo?sslmode=disable -path sql/migrations down $(number)

db-drop:
	migrate -database postgres://postgres:postgres@localhost:5432/demo?sslmode=disable -path sql/migrations drop

db-force:
	migrate -database postgres://postgres:postgres@localhost:5432/demo?sslmode=disable -path sql/migrations force $(version)

db-version:
	migrate -database postgres://postgres:postgres@localhost:5432/demo?sslmode=disable -path sql/migrations version
