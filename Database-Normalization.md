
# What are Normalization and Denormalization?

## Normalization

These are three rules for organizing data in a database. they help us to reduce redundancy and improve the integrity of our data.
1. First Normal Form (1NF)
2. Second Normal Form (2NF)
3. Third Normal Form (3NF)

These three rules are considered to be the standard level of optimization for business databases. Applying these rules is an important step in designing any database.

These rules are sets of formal criteria, and they build on top of each other, step by step. We move through the forms as we optimize our database to the third normal form.

Normalization helps us prevent problems in working with our data, and the process should be revisited whenever there's a change to the schema or the structure of a database.

### First Normal Form (1NF)

Values in each cell should be atomic and tables should have no repeating groups.

This means that each field in each table has only one value in it and that there are no columns representing repeated kinds of data for each row. The first normal form is often extended to include the idea that there aren't duplicate rows in a table. This also suggests that the order of rows and columns is not important to the data.

**First Normal Form rules:**
1. Each attribute should contain atomic value.
2. Each attribute should contain value from same domain.
3. Each attribute should contain unique name.
4. No ordering to rows and columns.
5. No duplicate rows.

### Second Normal Form (2NF)

No value in a table should depend on only part of a key that can be used to uniquely identify a row.

This means that for every column in the table that isn't a key, each of the values must rely on only the whole key. The values must describe something about that row that we can't determine from just the part of a key. This problem comes up in the context of composite keys. In the second normal form, we shouldn't be able to determine a value in a column from only part of a composite key.

**Second Normal Form rules:**
1. The relation should be in first normal form.
2. No partial dependency in the relation.

### Third Normal Form (3NF)

Values should not be stored if they can be calculated from another non-key field.

In the third normal form, we shouldn't be able to figure out any value in a column from a field that isn't a key.

Once your tables all satisfy the first, second, and third normal form, the database is normalized to the third normal form. This helps to guarantee that your database has low duplication, high integrity, and will be durable when you create, read, update, and delete entries.

**Third Normal Form rules:**
1. The relation should be in second normal form.
2. No nonprime attribute of R is transitively dependent on the primary key.

## Denormalization

The process of intentionally duplicating information in a table, in violation of normalization rules. 

Denormalization is done to a previously normalized database, it doesn't mean skipping normalization altogether. In some problems, we need to balance when we're making a decision to denormalize.

When we ask the database for an order summary, there's a lot of activity going on in the background and with a very large database, a very slow server, or a huge number of requests coming into the database at the same time, speed may be something we need to optimize for. So we would make the conscious decision to record the quantity and total at the time when we generate the order, to save time later and we would be aware of this risk to consistency and accuracy in our database.

Denormalization is a trade-off. Gaining speed may reduce consistency.

**By applying Normalization or Denormalization and that's a decision you'll need to make based on your own business requirements.**