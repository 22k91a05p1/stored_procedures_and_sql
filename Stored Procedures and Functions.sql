USE librarydb;
DELIMITER //

CREATE PROCEDURE GetBorrowedBooksByMember(IN memberName VARCHAR(100))
BEGIN
    SELECT b.title, br.borrow_date, br.return_date
    FROM Borrowed br
    JOIN Members m ON br.member_id = m.member_id
    JOIN Books b ON br.book_id = b.book_id
    WHERE m.name = memberName;
END //

DELIMITER ;
CALL GetBorrowedBooksByMember('Alice');
DELIMITER //

DELIMITER //

CREATE FUNCTION TotalBooksBorrowed(memberId INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM Borrowed
    WHERE member_id = memberId;
    RETURN total;
END //

DELIMITER ;
SELECT name, TotalBooksBorrowed(member_id) AS total_borrowed
FROM Members;
DELIMITER //
