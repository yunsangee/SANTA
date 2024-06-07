package site.dearmysanta.service.common;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;


import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.S3Object;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.InputStream;
import java.nio.file.Files;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;


@Service
public class ObjectStorageService {
	@Autowired
	private final AmazonS3 amazonS3;
	private final ObjectMapper objectMapper;
	
	@Value("${bucketName}")
	private String bucketName;

	
    public ObjectStorageService(AmazonS3 amazonS3, ObjectMapper objectMapper) {
        this.amazonS3 = amazonS3;
        this.objectMapper = objectMapper;
    }

	public void uploadFile(MultipartFile multipartFile, String fileName) throws IOException {
        File file = convertMultipartFileToFile(multipartFile);
        amazonS3.putObject(bucketName, fileName, file);
        Files.delete(file.toPath());  // 업로드 후 임시 파일 삭제
    }

    public MultipartFile downloadFile(String bucketName, String fileName) throws IOException {
        S3Object s3Object = amazonS3.getObject(bucketName, fileName);
        InputStream inputStream = s3Object.getObjectContent();

        File file = new File("/tmp/" + fileName);  // 임시 디렉토리에 저장
        FileOutputStream outputStream = new FileOutputStream(file);

        byte[] buffer = new byte[1024];
        int bytesRead;
        while ((bytesRead = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, bytesRead);
        }
        outputStream.close();
        inputStream.close();

        return convertFileToMultipartFile(file);
    }

    private File convertMultipartFileToFile(MultipartFile file) throws IOException {
        File convFile = new File(file.getOriginalFilename());
        FileOutputStream fos = new FileOutputStream(convFile);
        fos.write(file.getBytes());
        fos.close();
        return convFile;
    }

    private MultipartFile convertFileToMultipartFile(File file) throws IOException {
        FileInputStream fileInputStream = new FileInputStream(file);
        return new MockMultipartFile(file.getName(), file.getName(), "application/octet-stream", fileInputStream);
    }
    
    public void uploadListData(List<?> dataList, String fileName) throws IOException {
        String jsonString = objectMapper.writeValueAsString(dataList);
        byte[] byteArray = jsonString.getBytes();

        InputStream inputStream = new ByteArrayInputStream(byteArray);
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(byteArray.length);
        metadata.setContentType("application/json");

        amazonS3.putObject(bucketName, fileName, inputStream, metadata);
    }

    public List<?> downloadListData(String bucketName, String fileName, Class<?> elementType) throws IOException {
        S3Object s3Object = amazonS3.getObject(bucketName, fileName);
        InputStream inputStream = s3Object.getObjectContent();
        return objectMapper.readValue(inputStream, objectMapper.getTypeFactory().constructCollectionType(List.class, elementType));
    }
}
