package com.lms.studentlms.dao;

import com.lms.studentlms.model.Payment;
import com.lms.studentlms.model.PaymentRecord;
import com.lms.studentlms.util.FileUtils;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class PaymentDao extends BaseDao<PaymentRecord> {
    private static final String FILE_PATH = "C:\\Users\\USER\\OneDrive - Sri Lanka Institute of Information Technology\\Desktop\\New folder\\projectlms\\src\\main\\resources\\data\\ payments.txt";
    private static final String PAYMENT_RECORDS_PATH = "C:\\Users\\USER\\OneDrive - Sri Lanka Institute of Information Technology\\Desktop\\New folder\\projectlms\\src\\main\\resources\\data\\payment_records.txt";
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public PaymentDao() {
        super(PAYMENT_RECORDS_PATH);
    }

    public boolean savePayment(Payment payment) throws IOException {
        List<String> lines = new ArrayList<>();
        // Format: studentEmail,studentName,courseCode,courseName,courseFee,paymentMethod,transactionId,timestamp
        lines.add(payment.getStudentEmail() + "," +
                payment.getStudentName() + "," +
                payment.getCourseCode() + "," +
                payment.getCourseName() + "," +
                payment.getCourseFee() + "," +
                payment.getPaymentMethod() + "," +
                payment.getTransactionId() + "," +
                payment.getTimestamp());

        // Save to file (append mode)
        return FileUtils.writeLinesToFile(FILE_PATH, lines, true);
    }

    public List<Payment> getPaymentsByEmail(String userEmail) throws IOException {
        if (!FileUtils.fileExists(FILE_PATH)) {
            return new ArrayList<>();
        }

        return FileUtils.readLinesFromFile(FILE_PATH).stream()
                .map(line -> line.split(","))
                .filter(parts -> parts.length >= 8 && parts[0].equalsIgnoreCase(userEmail))
                .map(parts -> new Payment(
                        parts[0], // studentEmail
                        parts[1], // studentName
                        parts[2], // courseCode
                        parts[3], // courseName
                        parts[4], // courseFee
                        parts[5], // paymentMethod
                        parts[6], // transactionId
                        Long.parseLong(parts[7]) // timestamp
                ))
                .collect(Collectors.toList());
    }

    public Payment getPaymentByTransactionId(String transactionId) throws IOException {
        if (!FileUtils.fileExists(FILE_PATH)) {
            return null;
        }

        return FileUtils.readLinesFromFile(FILE_PATH).stream()
                .map(line -> line.split(","))
                .filter(parts -> parts.length >= 8 && parts[6].equals(transactionId))
                .map(parts -> new Payment(
                        parts[0], // studentEmail
                        parts[1], // studentName
                        parts[2], // courseCode
                        parts[3], // courseName
                        parts[4], // courseFee
                        parts[5], // paymentMethod
                        parts[6], // transactionId
                        Long.parseLong(parts[7]) // timestamp
                ))
                .findFirst()
                .orElse(null);
    }

    // Methods for PaymentRecord handling
    public boolean savePaymentRecord(PaymentRecord record) {
        try {
            List<String> lines = new ArrayList<>();
            lines.add(formatPaymentRecord(record));
            return FileUtils.writeLinesToFile(PAYMENT_RECORDS_PATH, lines, true);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<PaymentRecord> getAllPayments() {
        try {
            if (!FileUtils.fileExists(PAYMENT_RECORDS_PATH)) {
                return new ArrayList<>();
            }

            return FileUtils.readLinesFromFile(PAYMENT_RECORDS_PATH).stream()
                    .map(this::parsePaymentRecord)
                    .filter(record -> record != null)
                    .collect(Collectors.toList());
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public PaymentRecord getPaymentRecordByTransactionId(String transactionId) {
        return getAllPayments().stream()
                .filter(record -> record.getTransactionId().equals(transactionId))
                .findFirst()
                .orElse(null);
    }

    public List<PaymentRecord> getPaymentRecordsByEmail(String email) {
        return getAllPayments().stream()
                .filter(record -> record.getStudentEmail().equals(email))
                .collect(Collectors.toList());
    }

    public List<PaymentRecord> getPaymentsByStatus(String status) {
        return getAllPayments().stream()
                .filter(record -> record.getStatus().equals(status))
                .collect(Collectors.toList());
    }

    public boolean updatePaymentStatus(String transactionId, String newStatus) {
        try {
            if (!FileUtils.fileExists(PAYMENT_RECORDS_PATH)) {
                return false;
            }

            List<String> lines = FileUtils.readLinesFromFile(PAYMENT_RECORDS_PATH);
            List<String> updatedLines = new ArrayList<>();
            boolean updated = false;

            for (String line : lines) {
                PaymentRecord record = parsePaymentRecord(line);
                if (record != null && record.getTransactionId().equals(transactionId)) {
                    record.setStatus(newStatus);
                    updatedLines.add(formatPaymentRecord(record));
                    updated = true;
                } else {
                    updatedLines.add(line);
                }
            }

            if (updated) {
                FileUtils.writeLinesToFile(PAYMENT_RECORDS_PATH, updatedLines, false);
                return true;
            }

            return false;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean addPaymentNote(String transactionId, String note) {
        // Implementation for adding notes to payments
        // This would require extending the PaymentRecord model to include notes
        return false;
    }

    public double getTotalRevenue() {
        return getAllPayments().stream()
                .mapToDouble(PaymentRecord::getAmount)
                .sum();
    }

    public int getPendingPaymentsCount() {
        return (int) getAllPayments().stream()
                .filter(record -> "PENDING".equals(record.getStatus()))
                .count();
    }

    public int getCompletedPaymentsCount() {
        return (int) getAllPayments().stream()
                .filter(record -> "COMPLETED".equals(record.getStatus()))
                .count();
    }

    private String formatPaymentRecord(PaymentRecord record) {
        return record.getStudentEmail() + "," +
                record.getTransactionId() + "," +
                dateFormat.format(record.getDate()) + "," +
                record.getDescription() + "," +
                record.getAmount() + "," +
                record.getStatus();
    }

    private PaymentRecord parsePaymentRecord(String line) {
        try {
            String[] parts = line.split(",");
            if (parts.length >= 6) {
                return new PaymentRecord(
                        parts[0], // studentEmail
                        parts[1], // transactionId
                        dateFormat.parse(parts[2]), // date
                        parts[3], // description
                        Double.parseDouble(parts[4]), // amount
                        parts[5] // status
                );
            }
        } catch (ParseException | NumberFormatException e) {
            e.printStackTrace();
        }

        return null;
    }

    @Override
    protected PaymentRecord mapEntityFromLine(String line) {
        return parsePaymentRecord(line);
    }

    @Override
    protected String mapEntityToLine(PaymentRecord record) {
        return formatPaymentRecord(record);
    }
}
