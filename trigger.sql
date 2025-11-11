--trigger for Prevent Negative or Zero Prices or Quantities
CREATE TRIGGER trg_Validate_Price_Quantity
ON Orders
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM inserted
        WHERE Price <= 0 OR Quantity <= 0
    )
    BEGIN
        RAISERROR('Price and Quantity must be greater than zero.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;