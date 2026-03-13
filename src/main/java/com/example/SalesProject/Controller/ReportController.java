package com.example.SalesProject.Controller; // Change this to your actual package name!

import net.sf.jasperreports.engine.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import javax.sql.DataSource;
import java.io.InputStream;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

@RestController
public class ReportController {

    // This automatically grabs the database connection you set up in application.properties
    @Autowired
    private DataSource dataSource;

    @GetMapping("/pages/reports/customers")
    public ResponseEntity<byte[]> downloadCustomerReport() {
        try {
            // 1. Load the raw .jrxml XML file
            InputStream reportStream = new ClassPathResource("reports/CustomerList.jrxml").getInputStream();

            // 2. COMPILE the report on the fly!
            JasperReport jasperReport = JasperCompileManager.compileReport(reportStream);

            // 3. Open a connection to your database
            Connection connection = dataSource.getConnection();

            // 4. Fill the compiled report with live data
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, new HashMap<>(), connection);

            // 5. Convert the generated report into a PDF byte array
            byte[] pdfBytes = JasperExportManager.exportReportToPdf(jasperPrint);

            connection.close();

            // 6. Tell the browser to download this as a file
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_PDF);
            headers.setContentDispositionFormData("attachment", "CustomerList.pdf");

            return new ResponseEntity<>(pdfBytes, headers, HttpStatus.OK);

        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @GetMapping("/pages/reports/product-barcode")
    public ResponseEntity<byte[]> downloadProductBarcode() {
        try {
            // 1. Load the raw .jrxml XML file
            InputStream reportStream = new ClassPathResource("reports/ProductBarcodeList.jrxml").getInputStream();

            // 2. COMPILE the report on the fly!
            JasperReport jasperReport = JasperCompileManager.compileReport(reportStream);

            // 3. Open a connection to your database
            Connection connection = dataSource.getConnection();

            // 4. Fill the compiled report with live data
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, new HashMap<>(), connection);

            // 5. Convert the generated report into a PDF byte array
            byte[] pdfBytes = JasperExportManager.exportReportToPdf(jasperPrint);

            connection.close();

            // 6. Tell the browser to download this as a file
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_PDF);
            headers.setContentDispositionFormData("attachment", "ProductBarcodeList.pdf");

            return new ResponseEntity<>(pdfBytes, headers, HttpStatus.OK);

        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
    @GetMapping("/pages/reports/invoice/{orderId}")
    public ResponseEntity<byte[]> downloadInvoice(@PathVariable("orderId") Long orderId) {
        try {
            // 1. Load the Invoice .jrxml file (Make sure the name exactly matches your file in the resources folder!)
            InputStream reportStream = new ClassPathResource("reports/CustomersOrder.jrxml").getInputStream();

            // 2. Compile the report
            JasperReport jasperReport = JasperCompileManager.compileReport(reportStream);

            // 3. Open a connection to your database
            Connection connection = dataSource.getConnection();

            // 4. Set up the Parameters Map and push the orderId into it
            Map<String, Object> parameters = new HashMap<>();
            parameters.put("orderId", orderId);

            // 5. Fill the report using the specific parameters and connection
            JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, connection);

            // 6. Convert to PDF
            byte[] pdfBytes = JasperExportManager.exportReportToPdf(jasperPrint);

            connection.close();

            // 7. Return the PDF as a downloadable attachment with a dynamic filename
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_PDF);
            headers.setContentDispositionFormData("attachment", "CustomerOrderList" + orderId + ".pdf");

            return new ResponseEntity<>(pdfBytes, headers, HttpStatus.OK);

        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}