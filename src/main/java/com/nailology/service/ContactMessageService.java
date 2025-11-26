package com.nailology.service;

import com.nailology.model.ContactMessage;
import com.nailology.repository.ContactMessageRepository;
import org.springframework.stereotype.Service;

@Service
public class ContactMessageService {

    private final ContactMessageRepository repository;

    public ContactMessageService(ContactMessageRepository repository) {
        this.repository = repository;
    }

    public ContactMessage save(ContactMessage contactMessage) {
        return repository.save(contactMessage);
    }
}

