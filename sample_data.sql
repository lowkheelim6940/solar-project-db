INSERT INTO clients (client_id, first_name, last_name, email, signup_date, state_code, phone_number) VALUES
(1001, 'Alice', 'Green', 'alice.green@example.com', DATE '2023-01-10', 'CA', '555-1234');

INSERT INTO clients (client_id, first_name, last_name, email, signup_date, state_code, phone_number) VALUES
(1002, 'Bob', 'Smith', 'bob.smith@example.com', DATE '2022-11-15', 'NV', '555-2345');

INSERT INTO clients (client_id, first_name, last_name, email, signup_date, state_code, phone_number) VALUES
(1003, 'Clara', 'Hughes', 'clara.h@example.com', DATE '2022-12-05', 'AZ', '555-3456');

INSERT INTO clients (client_id, first_name, last_name, email, signup_date, state_code, phone_number) VALUES
(1004, 'Dan', 'Yoon', 'dan.yoon@example.com', DATE '2023-02-18', 'TX', '555-4567');

INSERT INTO clients (client_id, first_name, last_name, email, signup_date, state_code, phone_number) VALUES
(1005, 'Eva', 'Lopez', 'eva.lopez@example.com', DATE '2023-03-01', 'NM', '555-5678');


INSERT INTO paneltypes (panel_type_code, description) VALUES ('STD', 'Standard Efficiency');
INSERT INTO paneltypes (panel_type_code, description) VALUES ('PRM', 'Premium Efficiency');
INSERT INTO paneltypes (panel_type_code, description) VALUES ('ULH', 'Ultra High Efficiency');


INSERT INTO projects (project_id, client_id, project_name, panel_count, expected_kw, install_date, inspection_date, status) VALUES
(2001, 1001, 'Green Home', 20, 5.20, DATE '2023-02-01', DATE '2023-02-15', 'Inspected');

INSERT INTO projects (project_id, client_id, project_name, panel_count, expected_kw, install_date, inspection_date, status) VALUES
(2002, 1002, 'Bob Solar 1', 16, 4.80, DATE '2023-03-03', NULL, 'Installed');

INSERT INTO projects (project_id, client_id, project_name, panel_count, expected_kw, install_date, inspection_date, status) VALUES
(2003, 1003, 'Clara Rooftop', 25, 6.75, DATE '2023-03-12', NULL, 'Planned');

INSERT INTO projects (project_id, client_id, project_name, panel_count, expected_kw, install_date, inspection_date, status) VALUES
(2004, 1001, 'Green Cabin', 12, 3.20, DATE '2023-03-10', DATE '2023-03-22', 'Inspected');

INSERT INTO projects (project_id, client_id, project_name, panel_count, expected_kw, install_date, inspection_date, status) VALUES
(2005, 1004, 'Yoon Barn', 18, 4.95, DATE '2023-04-01', NULL, 'Installed');


INSERT INTO panels (panel_id, project_id, panel_type_code, capacity_kw, serial_number) VALUES
(3001, 2001, 'STD', 0.26, 'SN-001');

INSERT INTO panels (panel_id, project_id, panel_type_code, capacity_kw, serial_number) VALUES
(3002, 2001, 'STD', 0.26, 'SN-002');

INSERT INTO panels (panel_id, project_id, panel_type_code, capacity_kw, serial_number) VALUES
(3003, 2002, 'PRM', 0.30, 'SN-003');

INSERT INTO panels (panel_id, project_id, panel_type_code, capacity_kw, serial_number) VALUES
(3004, 2003, 'ULH', 0.35, 'SN-004');

INSERT INTO panels (panel_id, project_id, panel_type_code, capacity_kw, serial_number) VALUES
(3005, 2003, 'ULH', 0.35, 'SN-005');

INSERT INTO panels (panel_id, project_id, panel_type_code, capacity_kw, serial_number) VALUES
(3006, 2004, 'STD', 0.25, 'SN-006');

INSERT INTO panels (panel_id, project_id, panel_type_code, capacity_kw, serial_number) VALUES
(3007, 2004, 'STD', 0.25, 'SN-007');

INSERT INTO panels (panel_id, project_id, panel_type_code, capacity_kw, serial_number) VALUES
(3008, 2005, 'PRM', 0.30, 'SN-008');


INSERT INTO payments (payment_id, project_id, amount, payment_date, payment_method, note) VALUES
(4001, 2001, 5000.00, DATE '2023-02-02', 'Credit', 'Initial deposit');

INSERT INTO payments (payment_id, project_id, amount, payment_date, payment_method, note) VALUES
(4002, 2002, 4000.00, DATE '2023-03-05', 'ACH', NULL);

INSERT INTO payments (payment_id, project_id, amount, payment_date, payment_method, note) VALUES
(4003, 2003, 6200.00, DATE '2023-03-15', 'Check', 'Paid in full');

INSERT INTO payments (payment_id, project_id, amount, payment_date, payment_method, note) VALUES
(4004, 2001, 1500.00, DATE '2023-02-28', 'ACH', 'Final balance');

INSERT INTO payments (payment_id, project_id, amount, payment_date, payment_method, note) VALUES
(4005, 2004, 3200.00, DATE '2023-03-23', 'Credit', NULL);
