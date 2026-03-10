package com.example.SalesProject.GlobalExceptionHandling;

import com.example.SalesProject.CustomAnnotations.CustomExceptionScope;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.HandlerMethod;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {

    private Map<String, Object> buildResponse(String message, String error, HttpStatus status) {
        Map<String, Object> map = new HashMap<>();
        map.put("timestamp", LocalDateTime.now());
        map.put("status", status.value());
        map.put("error", error);
        map.put("message", message);
        return map;
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<?> handleInvalidJson(
            HttpMessageNotReadableException ex,
            HandlerMethod handlerMethod
    ) {

        boolean hasCustomScope =
                handlerMethod.hasMethodAnnotation(CustomExceptionScope.class)
                        || handlerMethod.getBeanType().isAnnotationPresent(CustomExceptionScope.class);

        if (hasCustomScope) {
            return new ResponseEntity<>(
                    buildResponse("Invalid JSON format in SAVE API", "INVALID_JSON", HttpStatus.BAD_REQUEST),
                    HttpStatus.BAD_REQUEST
            );
        }


        return new ResponseEntity<>(
                buildResponse("Invalid JSON format", "BAD_REQUEST", HttpStatus.BAD_REQUEST),
                HttpStatus.BAD_REQUEST
        );
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<Map<String, String>> handleValidationErrors(MethodArgumentNotValidException ex) {
        Map<String, String> errors = new HashMap<>();

        ex.getBindingResult().getFieldErrors().forEach(error ->
                errors.put(error.getField(), error.getDefaultMessage())
        );

        return ResponseEntity.badRequest().body(errors);
    }

    @ExceptionHandler(BadCredentialsException.class)
    public ResponseEntity<?> handleBadCredentials(BadCredentialsException ex) {
        return new ResponseEntity<>(
                buildResponse("Invalid password", "AUTH_FAILED", HttpStatus.UNAUTHORIZED),
                HttpStatus.UNAUTHORIZED
        );
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<?> handleGeneric(Exception ex) {
        return new ResponseEntity<>(
                buildResponse(ex.getMessage(), "INTERNAL_SERVER_ERROR", HttpStatus.INTERNAL_SERVER_ERROR),
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }
}