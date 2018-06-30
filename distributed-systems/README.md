# Distributed Systems in One Lesson

## Read Replication

Having one write instance and a load of read replications. Works only, if you have a lot more reads than writes. Typical for web traffic.

### Eventual Consistency

Changes might be not persisted immediately. Eventual reads will not reflect latest write.

## Sharding

Splitting data by a certain key across shards.

### Cons

- More complexity: choose right shard
- Limited data model: key-value store is easy, on relational database model needs to fit into a database
- Limited data access pattern: only simple queries, more complex spread across shards

## Consistent Hashing

Similar to Sharding, but key is hashed.

### Consistency

`R+W > N`

- R: Number of replicas that agree on read
- W: Number of replicas that successfully write
- N: Total number of replicas

## CAP Theorem

## Distributed Transactions

There is no performant solution (throughput) for atomic transactions within distributed transactions.

### ACID

- Atomic: A change is done or not at all
- Consistent: Database is not broken after transaction
- Isolation (Transaction Isolation): 4 different isolation levels
- Durable: Changes are stored

## Map Reduce

## Hadoop

## Spark

## Storm

## Lambda Architecture

## Synchronization

## Network Time Protocol

## Vector Clocks

## Distributed Consensu: Paxos

## Messaging Introduction

## Kafka

## Zookeeper

## Wrap-Up
