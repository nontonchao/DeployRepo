package com.example.oasip_back_nontonchao.controllers;

import com.example.oasip_back_nontonchao.dtos.AssociationGet;
import com.example.oasip_back_nontonchao.dtos.UserGet;
import com.example.oasip_back_nontonchao.dtos.UserUpdate;
import com.example.oasip_back_nontonchao.entities.User;
import com.example.oasip_back_nontonchao.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/users")
public class UserController {
    @Autowired
    UserService userService;

    @GetMapping("")
    @PreAuthorize("hasRole('ADMIN')")
    public List<UserGet> getUsers() {
        return userService.getAllUsers();
    }

    @GetMapping("/lecturers")
    @PreAuthorize("hasRole('ADMIN')")
    public List<UserGet> getLecturers() {
        return userService.getAllLecturers();
    }

    @GetMapping("/check/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public AssociationGet getAssociate(@PathVariable Integer id) {
        return userService.getAssociate(id);
    }

    @PostMapping("/create")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity createUser(@Valid @RequestBody User user) {
        return userService.createUser(user);
    }

    @PatchMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity editUser(@PathVariable Integer id, @Valid @RequestBody UserUpdate user) {
        return userService.updateUser(id, user);
    }

    @GetMapping("/check")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity emailCheck(@RequestParam String email) {
        return userService.checkEmail(email);
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public UserGet getUser(@PathVariable Integer id) {
        return userService.findUserByIdDTO(id);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity deleteUser(@PathVariable Integer id) {
        return userService.deleteUser(id);
    }

    @ResponseStatus(HttpStatus.BAD_REQUEST)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Map<String, String> handleValidationExceptions(MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();
        ex.getBindingResult().getAllErrors().forEach((error) -> {
            String fieldName = ((FieldError) error).getField();
            String errorMessage = error.getDefaultMessage();
            errors.put(fieldName, errorMessage);
        });
        return errors;
    }
}
