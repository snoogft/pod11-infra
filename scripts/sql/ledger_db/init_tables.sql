-- Copyright 2020 Google LLC
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

CREATE TABLE TRANSACTIONS (
    TRANSACTION_ID BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    FROM_ACCT CHAR(10) NOT NULL,
    TO_ACCT CHAR(10) NOT NULL,
    FROM_ROUTE CHAR(9) NOT NULL,
    TO_ROUTE CHAR(9) NOT NULL,
    AMOUNT INT NOT NULL,
    TIMESTAMP TIMESTAMP NOT NULL
);
-- index account number/routing number pairs
CREATE INDEX ON TRANSACTIONS (FROM_ACCT, FROM_ROUTE, TIMESTAMP);
CREATE INDEX ON TRANSACTIONS (TO_ACCT, TO_ROUTE, TIMESTAMP);
-- append only ledger; prevent updates or deletes
CREATE RULE PREVENT_UPDATE AS
  ON UPDATE TO TRANSACTIONS
  DO INSTEAD NOTHING;
CREATE RULE PREVENT_DELETE AS
  ON DELETE TO TRANSACTIONS
  DO INSTEAD NOTHING;