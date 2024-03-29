package com.example.oasip_back_nontonchao.services;

import com.example.oasip_back_nontonchao.dtos.EventCategoryGet;
import com.example.oasip_back_nontonchao.dtos.EventCategoryOwnerUpdate;
import com.example.oasip_back_nontonchao.entities.EventCategory;
import com.example.oasip_back_nontonchao.entities.EventCategoryOwner;
import com.example.oasip_back_nontonchao.filter.JwtRequestFilter;
import com.example.oasip_back_nontonchao.repositories.EventCategoryOwnerRepository;
import com.example.oasip_back_nontonchao.repositories.EventCategoryRepository;
import com.example.oasip_back_nontonchao.repositories.UserRepository;
import com.example.oasip_back_nontonchao.utils.JwtTokenUtil;
import com.example.oasip_back_nontonchao.utils.ListMapper;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class EventCategoryService {
    @Autowired
    private EventCategoryRepository repository;

    @Autowired
    private EventCategoryOwnerRepository eventCategoryOwnerRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private ListMapper listMapper;

    @Autowired
    private JwtTokenUtil jwtTokenUtil;

    public List<EventCategoryOwner> getEventCategoryOwner() {
        return eventCategoryOwnerRepository.findAll();
    }

    public ResponseEntity addEventCategoryOwner(EventCategoryOwnerUpdate e) {
        List<Integer> current_owner = eventCategoryOwnerRepository.getOwnersId(e.getEventCategory_id());
        List<Integer> new_owner = new ArrayList<Integer>();

        if (e.getUser_id().length <= 0) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("eventCategory owner should have at least 1!");
        }


        for (int i = 0; i < e.getUser_id().length; i++) {
            if (!eventCategoryOwnerRepository.existsEventCategoryOwnerByEventCategory_IdAndUser_Id(e.getEventCategory_id(), e.getUser_id()[i])) {
                if(!userRepository.findById(e.getUser_id()[i]).get().getRole().equals("lecturer")){
                    return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("eventcategory owner should be lecturer");
                }
            }
        }

        for (int i = 0; i < e.getUser_id().length; i++) {
            if (!eventCategoryOwnerRepository.existsEventCategoryOwnerByEventCategory_IdAndUser_Id(e.getEventCategory_id(), e.getUser_id()[i])) {
                    eventCategoryOwnerRepository.addEventCategoryOwner(e.getEventCategory_id(), e.getUser_id()[i]);
                }
                new_owner.add(e.getUser_id()[i]);
            }


        List<Integer> except = current_owner.stream().filter(i -> !new_owner.contains(i)).collect(Collectors.toList());
        except.forEach(ex -> {
            eventCategoryOwnerRepository.deleteEventCategoryOwnersByEventCategoryIdAndUserId(e.getEventCategory_id(), ex);
        });
        return ResponseEntity.status(HttpStatus.CREATED).body("eventCategory owner edited!");
    }

    public List<EventCategoryGet> getEventCategory() {
        List<EventCategoryGet> eventCategories = listMapper.mapList(repository.findAll(), EventCategoryGet.class, modelMapper);
        eventCategories.forEach(eventCategory -> {
            eventCategory.setOwners(eventCategoryOwnerRepository.getOwners(eventCategory.getId()));
        });
        return eventCategories;
    }


    public ResponseEntity editEventCategory(EventCategory update, Integer id) {
        String email = jwtTokenUtil.getUsernameFromToken(JwtRequestFilter.getJwtToken_());
        Optional<EventCategory> s = repository.findById(id);
        if (!s.isEmpty()) {
            List<EventCategory> toCheck = repository.findAllByEventCategoryNameAndIdIsNot(update.getEventCategoryName().stripLeading().stripTrailing(), id);
            if (toCheck.stream().count() == 0) {

                if(!jwtTokenUtil.getRoleFromToken(JwtRequestFilter.getJwtToken_()).equals("ROLE_ADMIN")){
                    if (eventCategoryOwnerRepository.existsEventCategoryOwnerByEventCategory_IdAndUser_Id(id, userRepository.findUserIdByEmail(email))) {
                        s.get().setEventCategoryName(update.getEventCategoryName());
                        s.get().setEventDuration(update.getEventDuration());
                        s.get().setEventCategoryDescription(update.getEventCategoryDescription());
                        s.get().setEventCategoryStatus(update.getEventCategoryStatus());
                        repository.saveAndFlush(s.get());
                    } else {
                        return new ResponseEntity("this eventCategory is not yours!", HttpStatus.UNAUTHORIZED);
                    }
                } else {
                    s.get().setEventCategoryName(update.getEventCategoryName());
                    s.get().setEventDuration(update.getEventDuration());
                    s.get().setEventCategoryDescription(update.getEventCategoryDescription());
                    s.get().setEventCategoryStatus(update.getEventCategoryStatus());
                    repository.saveAndFlush(s.get());
                    return ResponseEntity.ok("EventCategory Edited! || eventCategory id: " + s.get().getId());
                }
                return ResponseEntity.ok("EventCategory Edited! || eventCategory id: " + s.get().getId());
            } else {
                return new ResponseEntity("eventCategoryName should be unique", HttpStatus.BAD_REQUEST);
            }
        } else {
            return new ResponseEntity("eventCategory not found!", HttpStatus.BAD_REQUEST);
        }
    }
}
