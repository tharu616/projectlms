package com.lms.studentlms.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

public class User {
    private String fullName;
    private String nic;
    private String email;
    private String password;
    private String dateOfBirth;
    private String gender;
    private String mobileNumber;
    private String whatsAppNumber;
    private String permanentAddress;
    private String districtOrProvince;
    private String postalCode;
    private String indexNumber;
    private String yearOfCompletion;
    private List<String> certificates;
    private String parentFullName;
    private String parentContactNumber;
    private String parentEmail;
    private long timestamp;
    private String registerNumber;

    public User() {
        this.certificates = new ArrayList<>();
        this.timestamp = System.currentTimeMillis();
    }

    public User(String fullName, String nic, String email, String password, String dateOfBirth, String gender,
                String mobileNumber, String whatsAppNumber, String permanentAddress, String districtOrProvince,
                String postalCode, String indexNumber, String yearOfCompletion, List<String> certificates,
                String parentFullName, String parentContactNumber, String parentEmail) {
        this.fullName = fullName;
        this.nic = nic;
        this.email = email;
        this.password = password;
        this.dateOfBirth = dateOfBirth;
        this.gender = gender;
        this.mobileNumber = mobileNumber;
        this.whatsAppNumber = whatsAppNumber;
        this.permanentAddress = permanentAddress;
        this.districtOrProvince = districtOrProvince;
        this.postalCode = postalCode;
        this.indexNumber = indexNumber;
        this.yearOfCompletion = yearOfCompletion;
        this.certificates = certificates != null ? certificates : new ArrayList<>();
        this.parentFullName = parentFullName;
        this.parentContactNumber = parentContactNumber;
        this.parentEmail = parentEmail;
        this.timestamp = System.currentTimeMillis();
    }

    // Getters and Setters
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getDateOfBirth() { return dateOfBirth; }
    public void setDateOfBirth(String dateOfBirth) { this.dateOfBirth = dateOfBirth; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getMobileNumber() { return mobileNumber; }
    public void setMobileNumber(String mobileNumber) { this.mobileNumber = mobileNumber; }

    public String getWhatsAppNumber() { return whatsAppNumber; }
    public void setWhatsAppNumber(String whatsAppNumber) { this.whatsAppNumber = whatsAppNumber; }

    public String getPermanentAddress() { return permanentAddress; }
    public void setPermanentAddress(String permanentAddress) { this.permanentAddress = permanentAddress; }

    public String getDistrictOrProvince() { return districtOrProvince; }
    public void setDistrictOrProvince(String districtOrProvince) { this.districtOrProvince = districtOrProvince; }

    public String getPostalCode() { return postalCode; }
    public void setPostalCode(String postalCode) { this.postalCode = postalCode; }

    public String getIndexNumber() { return indexNumber; }
    public void setIndexNumber(String indexNumber) { this.indexNumber = indexNumber; }

    public String getYearOfCompletion() { return yearOfCompletion; }
    public void setYearOfCompletion(String yearOfCompletion) { this.yearOfCompletion = yearOfCompletion; }

    public List<String> getCertificates() { return certificates; }
    public void setCertificates(List<String> certificates) { this.certificates = certificates; }

    public String getParentFullName() { return parentFullName; }
    public void setParentFullName(String parentFullName) { this.parentFullName = parentFullName; }

    public String getParentContactNumber() { return parentContactNumber; }
    public void setParentContactNumber(String parentContactNumber) { this.parentContactNumber = parentContactNumber; }

    public String getParentEmail() { return parentEmail; }
    public void setParentEmail(String parentEmail) { this.parentEmail = parentEmail; }

    public long getTimestamp() { return timestamp; }
    public void setTimestamp(long timestamp) { this.timestamp = timestamp; }

    public String getRegisterNumber() { return registerNumber; }
    public void setRegisterNumber(String registerNumber) { this.registerNumber = registerNumber; }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return Objects.equals(email, user.email);
    }

    @Override
    public int hashCode() {
        return Objects.hash(email);
    }

    @Override
    public String toString() {
        return "User{" +
                "fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", registerNumber='" + registerNumber + '\'' +
                '}';
    }
}
