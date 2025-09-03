# README

#### System dependencies

- Rails 7.x.x

#### Configuration

- run bin/setup
- start server with `rails s`
- test endpoints

#### Design Decision

- Added proper foreign key from invoices.bill_of_lading_number to bill_of_lading.number for data integrity
- Translated some (used) French column names to English while preserving legacy data structure
- Maintained legacy integer IDs instead of Rails UUIDs for compatibility

- Assumed Associations [Link](https://excalidraw.com/#json=fYeDYiksLdq7rfNDHp0A3,M2NvaKXIekky2zFQLs_osA)

  - Customer ↔ BillOfLading (one-to-many).
  - Customer ↔ Invoice (one-to-many).
  - BillOfLading ↔ Invoice (one-to-many).

- InvoiceGenerator handles only invoice creation logic. This follows the Single Responsibility Principle.
- Wrapped all operations in database transaction for atomic actions and safety.
- Handle error properly by, continuing to process other BLs even if one fails
- Logging and summary reporting

- Followed Rails conventions for resource-based URLs
- Used a consistent structure for json response with metadata (counts, totals)
- In error handling, used proper HTTP status codes and error details

### Curl Request Examples

- Get overdue invoices: curl -X GET -H "Content-Type: application/json" http://localhost:3000/invoices/overdue
- Generate invoices for overdue Bill of Ladings: curl -X POST -H "Content-Type: application/json" http://localhost:3000/invoices/generate
