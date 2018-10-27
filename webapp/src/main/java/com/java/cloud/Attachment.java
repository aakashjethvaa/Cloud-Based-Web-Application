package com.java.cloud;


import javax.persistence.*;
import javax.validation.constraints.NotNull;

@Entity(name="Attachment")
@Table(name = "attachment")
public class Attachment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "Id", unique = true, nullable = false)
    private Long Id;


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="transaction_id")
    private Transaction transaction;

    @Column(name="url")
    @NotNull
    private String url;

    public Transaction getTransaction() {
        return transaction;
    }

    public void setTransaction(Transaction transaction) {
        this.transaction = transaction;
    }


    public Long getId() {
        return Id;
    }

    public void setId(Long id) {
        this.Id = id;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }



}
