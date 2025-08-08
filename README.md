# Hospital-Information-Management-System-HIMS-
A complete MySQL-based Hospital Information Management System designed to manage hospital operations including patient registration, doctor scheduling, appointments, billing, payments, medical records, prescriptions, and pharmacy inventory.

The Hospital Information Management System (HIMS) is a MySQL-based database project designed to digitize and centralize various operational processes of a hospital. It handles patient registration, doctor scheduling, appointment booking, medical records, billing, payments, and pharmacy inventory, providing an efficient and scalable solution for hospital administration.

Objectives
1.To eliminate manual record-keeping by automating hospital workflows.
2.To provide accurate, secure, and easily retrievable patient and doctor information.
3.To streamline appointment booking and billing processes.
4.To track medicine inventory and prescriptions.
5.To support multi-role access (admin, doctor, pharmacist, receptionist) for secure operations.

| Component    | Technology Used          | Purpose                                    |
| ------------ | ------------------------ | ------------------------------------------ |
| **Database** | MySQL                    | Backend database for storing all data.     |
| **SQL**      | DDL & DML Scripts        | For schema design, insertion, and queries. |
| **Tool**     | MySQL Workbench          | GUI for database creation and management.  |
| **Optional** | HTML, CSS, JS (frontend) | For developing UI in future expansion.     |
| **OS**       | Windows / Linux          | Platform for development and deployment.   |

ER Diagram (Description)
The system contains the following key entities and relationships:

Departments ⟶ has many Doctors
Doctors ⟶ handles many Appointments and MedicalRecords
Patients ⟶ books Appointments, has MedicalRecords
Appointments ⟶ linked to Billing
MedicalRecords ⟶ can generate Prescriptions
Pharmacy ⟶ stores medicines linked in Prescriptions
Payments ⟶ linked to Billing

<img width="659" height="757" alt="Advanced_HIMS_ER_Diagram" src="https://github.com/user-attachments/assets/303a250c-7703-4521-97fe-7769fb8e72c0" />

<img width="768" height="114" alt="hims_er_diagram" src="https://github.com/user-attachments/assets/a14eda34-1db3-4dd3-9528-c73b4bc79beb" />

 Use Case Scenarios
🔹 Patient Registration
Capture patient name, gender, DOB, address, and contact number.

🔹 Appointment Booking
Link patients with doctors for specific dates. Track status (Scheduled, Completed, Cancelled).

🔹 Medical Record Management
Doctors record diagnosis and prescribe medicines. Linked with medical records and prescriptions.

🔹 Pharmacy Module
Track medicines, available stock, price. Update stock when prescribed.

🔹 Billing & Payment
Automatically generate bills based on appointments. Record payments with status and method.

🔹 Admin & Reporting
Admin can query system for reports like:
Daily appointments
Patient history
Billing reports
Stock status


📄 Report Summary

The Hospital Information Management System (HIMS) offers a relational database structure to manage critical data related to hospital operations. With normalized tables and foreign key constraints, the system ensures data integrity, prevents redundancy, and supports efficient querying.

This database solution can serve as a foundation for a full-fledged web or desktop hospital management application, integrating authentication, admin panels, and report generation in the future.

✅ Conclusion

The HIMS database project successfully demonstrates how structured relational models can handle complex real-world scenarios. It improves hospital service delivery by digitizing and linking all key records, making the process faster, more reliable, and easier to scale.


