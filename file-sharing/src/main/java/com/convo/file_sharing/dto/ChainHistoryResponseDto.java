package com.convo.file_sharing.dto;

import java.time.OffsetDateTime;
import java.util.UUID;

public record ChainHistoryResponseDto(
        UUID transferId,
        UUID sessionId,
        UUID originSessionId,
        UUID senderId,
        String fileName,
        Long fileSize,
        String mimeType,
        OffsetDateTime timestamp,
        String previousHash,
        String contentHash
) {}
