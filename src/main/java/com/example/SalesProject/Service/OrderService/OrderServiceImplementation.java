package com.example.SalesProject.Service.OrderService;
import com.example.SalesProject.DTOs.OrderItemRequestDTO;
import com.example.SalesProject.DTOs.OrderTableDTO;
import com.example.SalesProject.DTOs.PlaceOrderRequestDTO;
import com.example.SalesProject.Entity.Customer;
import com.example.SalesProject.Entity.Enum.OrderStatus;
import com.example.SalesProject.Entity.Order;
import com.example.SalesProject.Entity.OrderItem;
import com.example.SalesProject.Entity.Product;
import com.example.SalesProject.Repository.CustomerRepository;
import com.example.SalesProject.Repository.OrderRepository;
import com.example.SalesProject.Repository.ProductRepository;
import jakarta.transaction.Transactional;
import org.jspecify.annotations.NonNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class OrderServiceImplementation implements OrderService {

    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @CacheEvict(value = "orders", allEntries = true)
    public Long placeOrder(PlaceOrderRequestDTO request) {

        Customer customer = customerRepository.findById(request.getCustomerId())
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        Order order = new Order();
        order.setCustomer(customer);
        order.setStatus(OrderStatus.PLACED);

        double total = 0;
        List<OrderItem> items = new ArrayList<>();

        // 2. Process items
        for (OrderItemRequestDTO reqItem : request.getItems()) {

            Product product = productRepository.findById(reqItem.getProductId())
                    .orElseThrow(() -> new RuntimeException("Product not found"));

            Integer stock = productRepository.getStock(product.getId());
            if (stock < reqItem.getQuantity()) {
                throw new RuntimeException("Insufficient stock for product: " + product.getName());
            }

            Double price = productRepository.getPrice(product.getId());

            OrderItem item = new OrderItem();
            item.setOrder(order);
            item.setProduct(product);
            item.setQuantity(reqItem.getQuantity());
            item.setUnitPrice(price);
            item.setDiscount(0.0);
            item.setSubtotal(price * reqItem.getQuantity());

            total += item.getSubtotal();
            items.add(item);

            productRepository.reduceStock(product.getId(), reqItem.getQuantity());
        }


        order.setTotalAmount(total);
        order.setItems(items);

        Order savedOrder = orderRepository.save(order);
        return savedOrder.getId();
    }

    public Map<String, Object> getOrdersPage(int page, int length, int draw, String search) {

        PageRequest pageable = PageRequest.of(page, length);
        Page<OrderTableDTO> orderPage = orderRepository.getOrdersPage(search,pageable);
        List<Map<String, Object>> data = new ArrayList<>();
        for (OrderTableDTO o : orderPage.getContent()) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", o.getId());
            map.put("orderDate", o.getOrderDate());
            map.put("status", o.getStatus());
            map.put("totalAmount", o.getTotalAmount());
            map.put("customerName", o.getCustomerName());
            data.add(map);
        }

        Map<String, Object> response = new HashMap<>();
        response.put("draw", draw);
        response.put("recordsTotal", orderPage.getTotalElements());
        response.put("recordsFiltered", orderPage.getTotalElements());
        response.put("data", data);

        return response;
    }


    @Cacheable(value = "orders")
    public List<Map<String, Object>> viewOrders() {

        List<Order> orders = orderRepository.findAll();
        List<Map<String, Object>> result = new ArrayList<>();

        for (Order order : orders) {

            Map<String, Object> orderMap = new HashMap<>();
            orderMap.put("order_id", order.getId());
            orderMap.put("order_date", order.getOrderDate());
            orderMap.put("status", order.getStatus());
            orderMap.put("total_amount", order.getTotalAmount());
            orderMap.put("customer_id", order.getCustomer().getId());
            orderMap.put("customer_name", order.getCustomer().getFirstName() + " " + order.getCustomer().getLastName());
            List<Map<String, Object>> itemsList = getMaps(order);

            orderMap.put("items", itemsList);
            result.add(orderMap);
        }

        return result;
    }

    private static @NonNull List<Map<String, Object>> getMaps(Order order) {
        List<Map<String, Object>> itemsList = new ArrayList<>();

        for (OrderItem item : order.getItems()) {
            Map<String, Object> itemMap = new HashMap<>();
            itemMap.put("product_id", item.getProduct().getId());
            itemMap.put("product_name", item.getProduct().getName());
            itemMap.put("quantity", item.getQuantity());
            itemMap.put("unit_price", item.getUnitPrice());
            itemMap.put("discount", item.getDiscount());
            itemMap.put("subtotal", item.getSubtotal());

            itemsList.add(itemMap);
        }
        return itemsList;
    }


}
