<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="Contact Messages - Admin Panel" />
</jsp:include>

<meta name="context-path" content="${pageContext.request.contextPath}">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<style>
.d-flex.gap-1 {
    gap: 0.25rem !important;
}

.btn-sm {
    padding: 0.25rem 0.5rem !important;
    font-size: 0.775rem !important;
    line-height: 1.35 !important;
    border-radius: 0.375rem !important;
    min-width: 32px !important;
    height: 32px !important;
    display: inline-flex !important;
    align-items: center !important;
    justify-content: center !important;
}

.btn-sm i {
    font-size: 0.875rem !important;
    margin: 0 !important;
}

.btn-outline-primary:hover {
    background-color: #0d6efd !important;
    border-color: #0d6efd !important;
    color: white !important;
}

.btn-outline-info:hover {
    background-color: #0dcaf0 !important;
    border-color: #0dcaf0 !important;
    color: #000 !important;
}

.btn-outline-success:hover {
    background-color: #198754 !important;
    border-color: #198754 !important;
    color: white !important;
}

.btn-outline-warning:hover {
    background-color: #ffc107 !important;
    border-color: #ffc107 !important;
    color: #000 !important;
}

.btn-outline-danger:hover {
    background-color: #dc3545 !important;
    border-color: #dc3545 !important;
    color: white !important;
}

.table td .d-flex {
    white-space: nowrap;
}

.table-responsive {
    overflow-x: auto !important;
}

td:last-child {
    min-width: 180px;
}
</style>

<jsp:include page="../includes/navigation.jsp">
    <jsp:param name="currentPage" value="admin" />
</jsp:include>

<div class="container-fluid my-4">
    <div class="row">
        <div class="col-md-3 col-lg-2">
            <div class="card border-0 shadow-sm">
                <div class="card-header">
                    <h6 class="mb-0" data-i18n="admin.panel">Admin Panel</h6>
                </div>
                <div class="list-group list-group-flush">
                    <a href="${pageContext.request.contextPath}/admin/destinations" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-map-marker-alt me-2"></i><span data-i18n="admin.menu.destinations">Destinations</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/packages" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-box me-2"></i><span data-i18n="admin.menu.packages">Packages</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/bookings" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-calendar-check me-2"></i><span data-i18n="admin.menu.bookings">Bookings</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/users" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-users me-2"></i><span data-i18n="admin.menu.users">Users</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/messages" 
                       class="list-group-item list-group-item-action active">
                        <i class="fas fa-envelope me-2"></i><span data-i18n="admin.menu.messages">Messages</span>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-9 col-lg-10">
            <div class="admin-content">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h1 class="h3 mb-0">
                            <i class="fas fa-envelope me-2 text-primary"></i>
                            <span data-i18n="admin.messages.title">Contact Messages</span>
                        </h1>
                        <p class="text-muted" data-i18n="admin.messages.subtitle">Manage customer inquiries and communications</p>
                    </div>
                    <div class="d-flex gap-2">
                        <button class="btn btn-outline-success" onclick="markAllAsRead()">
                            <i class="fas fa-check-double me-2"></i><span data-i18n="admin.messages.markAllRead">Mark All Read</span>
                        </button>
                        <button class="btn btn-outline-danger" onclick="deleteSelected()">
                            <i class="fas fa-trash me-2"></i><span data-i18n="admin.messages.deleteSelected">Delete Selected</span>
                        </button>
                    </div>
                </div>

                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body text-center">
                                <div class="d-flex align-items-center justify-content-center">
                                    <i class="fas fa-envelope fa-2x text-primary me-3"></i>
                                    <div>
                                        <h4 class="mb-0" id="totalMessages">${fn:length(messages)}</h4>
                                        <small class="text-muted" data-i18n="admin.messages.total">Total Messages</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body text-center">
                                <div class="d-flex align-items-center justify-content-center">
                                    <i class="fas fa-circle fa-2x text-danger me-3"></i>
                                    <div>
                                        <h4 class="mb-0" id="newMessages">
                                            <c:set var="newCount" value="0" />
                                            <c:forEach var="message" items="${messages}">
                                                <c:if test="${message.status == 'NEW'}">
                                                    <c:set var="newCount" value="${newCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                            ${newCount}
                                        </h4>
                                        <small class="text-muted" data-i18n="admin.messages.new">New Messages</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body text-center">
                                <div class="d-flex align-items-center justify-content-center">
                                    <i class="fas fa-eye fa-2x text-warning me-3"></i>
                                    <div>
                                        <h4 class="mb-0" id="inProgressMessages">
                                            <c:set var="readCount" value="0" />
                                            <c:forEach var="message" items="${messages}">
                                                <c:if test="${message.status == 'read'}">
                                                    <c:set var="readCount" value="${readCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                            ${readCount}
                                        </h4>
                                        <small class="text-muted" data-i18n="admin.messages.read">Read Messages</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card border-0 shadow-sm">
                            <div class="card-body text-center">
                                <div class="d-flex align-items-center justify-content-center">
                                    <i class="fas fa-check fa-2x text-success me-3"></i>
                                    <div>
                                        <h4 class="mb-0" id="repliedMessages">
                                            <c:set var="repliedCount" value="0" />
                                            <c:forEach var="message" items="${messages}">
                                                <c:if test="${message.status == 'REPLIED'}">
                                                    <c:set var="repliedCount" value="${repliedCount + 1}" />
                                                </c:if>
                                            </c:forEach>
                                            ${repliedCount}
                                        </h4>
                                        <small class="text-muted" data-i18n="admin.messages.replied">Replied Messages</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th scope="col">
                                    <input type="checkbox" class="form-check-input" id="selectAll">
                                </th>
                                <th scope="col" data-i18n="admin.messages.th.status">Status</th>
                                <th scope="col" data-i18n="admin.messages.th.from">From</th>
                                <th scope="col" data-i18n="admin.messages.th.subject">Subject</th>
                                <th scope="col" data-i18n="admin.messages.th.preview">Message Preview</th>
                                <th scope="col" data-i18n="admin.messages.th.date">Date</th>
                                <th scope="col" data-i18n="admin.messages.th.actions">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty messages}">
                                    <tr>
                                        <td colspan="7" class="text-center py-5">
                                            <i class="fas fa-envelope fa-4x text-muted mb-3"></i>
                                            <h4 class="text-muted" data-i18n="admin.messages.empty.title">No messages found</h4>
                                            <p class="text-muted" data-i18n="admin.messages.empty.desc">Contact messages will appear here when customers send inquiries</p>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="message" items="${messages}">
                                        <tr data-message-id="${message.id}" class="${message.status == 'NEW' ? 'table-warning' : ''}">
                                            <td>
                                                <input type="checkbox" class="form-check-input row-select" 
                                                       value="${message.id}">
                                            </td>
                                            <td>
                                                <select class="form-select form-select-sm status-select" 
                                                        data-id="${message.id}" 
                                                        data-field="status"
                                                        data-original="${message.status}">
                                                    <option value="NEW" ${message.status == 'NEW' ? 'selected' : ''}>New</option>
                                                    <option value="read" ${message.status == 'read' ? 'selected' : ''}>Read</option>
                                                    <option value="REPLIED" ${message.status == 'REPLIED' ? 'selected' : ''}>Replied</option>
                                                    <option value="CLOSED" ${message.status == 'CLOSED' ? 'selected' : ''}>Closed</option>
                                                </select>
                                            </td>
                                            <td>
                                                <div class="contact-info">
                                                    <strong>${message.name}</strong>
                                                    <small class="text-muted d-block">${message.email}</small>
                                                    <c:if test="${not empty message.phone}">
                                                        <small class="text-muted d-block">${message.phone}</small>
                                                    </c:if>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="subject-info">
                                                    <strong>${message.subject}</strong>
                                                    <c:if test="${message.status == 'NEW'}">
                                                    <span class="badge bg-danger ms-2" data-i18n="admin.messages.newBadge">New</span>
                                                    </c:if>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="message-preview">
                                                    <p class="mb-0 text-truncate" style="max-width: 300px;" title="${message.message}">
                                                        ${fn:substring(message.message, 0, 100)}...
                                                    </p>
                                                </div>
                                            </td>
                                            <td>
                                                <small class="text-muted">
                                                    <c:choose>
                                                        <c:when test="${message.createdAt != null}">
                                                            <c:out value="${message.createdAt.toString().substring(0, 10)}" />
                                                            <br>
                                                            <c:out value="${message.createdAt.toString().substring(11, 16)}" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            Not available
                                                        </c:otherwise>
                                                    </c:choose>
                                                </small>
                                            </td>
                                            <td>
                                                <div class="d-flex gap-1 justify-content-start">
                                                    <button type="button" class="btn btn-sm btn-outline-info" 
                                                            onclick="viewMessage(${message.id})"
                                                            title="View Full Message" data-i18n-attr='{"title":"admin.messages.viewFull"}'>
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                    <button type="button" class="btn btn-sm btn-outline-success" 
                                                            onclick="replyMessage(${message.id})"
                                                            title="Reply" data-i18n-attr='{"title":"admin.messages.reply"}'>
                                                        <i class="fas fa-reply"></i>
                                                    </button>
                                                    <button type="button" class="btn btn-sm btn-outline-danger" 
                                                            onclick="deleteMessage(${message.id})"
                                                            title="Delete" data-i18n-attr='{"title":"admin.common.delete"}'>
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="viewMessageModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-envelope me-2"></i><span data-i18n="admin.messages.view.title">Message Details</span>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label fw-bold" data-i18n="admin.messages.view.from">From:</label>
                        <p id="viewMessageName" class="mb-0"></p>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold" data-i18n="admin.messages.view.email">Email:</label>
                        <p id="viewMessageEmail" class="mb-0"></p>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold" data-i18n="admin.messages.view.phone">Phone:</label>
                        <p id="viewMessagePhone" class="mb-0"></p>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold" data-i18n="admin.messages.view.date">Date:</label>
                        <p id="viewMessageDate" class="mb-0"></p>
                    </div>
                    <div class="col-12">
                        <label class="form-label fw-bold" data-i18n="admin.messages.view.subject">Subject:</label>
                        <p id="viewMessageSubject" class="mb-0"></p>
                    </div>
                    <div class="col-12">
                        <label class="form-label fw-bold" data-i18n="admin.messages.view.message">Message:</label>
                        <div id="viewMessageContent" class="border rounded p-3 bg-light"></div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" data-i18n="common.close">Close</button>
                <button type="button" class="btn btn-success" onclick="showReplyModal()">
                    <i class="fas fa-reply me-2"></i><span data-i18n="admin.messages.reply">Reply</span>
                </button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="replyMessageModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-reply me-2"></i><span data-i18n="admin.messages.replyTitle">Reply to Message</span>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form id="replyMessageForm">
                <input type="hidden" id="replyMessageId" name="messageId">
                <div class="modal-body">
                    <div class="alert alert-info">
                        <strong data-i18n="admin.messages.to">To:</strong> <span id="replyToEmail"></span><br>
                        <strong data-i18n="admin.messages.subject">Subject:</strong> Re: <span id="replySubject"></span>
                    </div>
                    <div class="mb-3">
                        <label for="replyContent" class="form-label" data-i18n="admin.messages.replyContent">Your Reply <span class="text-danger">*</span></label>
                        <textarea class="form-control" id="replyContent" name="replyContent" rows="8" required 
                                  placeholder="Type your reply here..." data-i18n-attr='{"placeholder":"admin.messages.replyPlaceholder"}'></textarea>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="markAsReplied" name="markAsReplied" checked>
                        <label class="form-check-label" for="markAsReplied" data-i18n="admin.messages.markAsReplied">
                            Mark message as replied
                        </label>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" data-i18n="common.close">Cancel</button>
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-send me-2"></i><span data-i18n="admin.messages.sendReply">Send Reply</span>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
const contextPath = '${pageContext.request.contextPath}';
let currentMessageId = null;

document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.status-select').forEach(select => {
        select.addEventListener('change', function() {
            updateMessageStatus(this);
        });
    });

    const selectAllCheckbox = document.getElementById('selectAll');
    selectAllCheckbox.addEventListener('change', function() {
        const checkboxes = document.querySelectorAll('.row-select');
        checkboxes.forEach(checkbox => {
            checkbox.checked = this.checked;
        });
    });

    document.getElementById('replyMessageForm').addEventListener('submit', function(e) {
        e.preventDefault();
        
        const formData = new FormData(this);
        const replyData = {
            messageId: formData.get('messageId'),
            replyContent: formData.get('replyContent'),
            markAsReplied: formData.get('markAsReplied') === 'on'
        };
        
        fetch(contextPath + '/admin/messages/reply', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(replyData)
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                showNotification('Reply sent successfully', 'success');
                const modal = bootstrap.Modal.getInstance(document.getElementById('replyMessageModal'));
                modal.hide();
                location.reload();
            } else {
                showNotification('Failed to send reply', 'error');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showNotification('Error sending reply', 'error');
        });
    });
});

function updateMessageStatus(element) {
    const messageId = element.dataset.id;
    const status = element.value;

    fetch(contextPath + '/admin/messages/update-status', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            id: messageId,
            status: status
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            showNotification('Message status updated successfully', 'success');
            updateStatistics();
            
            const row = element.closest('tr');
            if (status == 'NEW') {
                row.classList.add('table-warning');
            } else {
                row.classList.remove('table-warning');
            }
        } else {
            showNotification('Failed to update message status', 'error');
            element.value = element.dataset.original;
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showNotification('Error updating message status', 'error');
        element.value = element.dataset.original;
    });
}

function viewMessage(id) {
    currentMessageId = id;
    
    fetch(contextPath + '/admin/messages/' + id)
        .then(response => response.json())
        .then(message => {
            if (message.success) {
                document.getElementById('viewMessageName').textContent = message.name;
                document.getElementById('viewMessageEmail').textContent = message.email;
                document.getElementById('viewMessagePhone').textContent = message.phone || 'Not provided';
                document.getElementById('viewMessageDate').textContent = new Date(message.createdAt).toLocaleString();
                document.getElementById('viewMessageSubject').textContent = message.subject;
                document.getElementById('viewMessageContent').textContent = message.message;
                
                const modal = new bootstrap.Modal(document.getElementById('viewMessageModal'));
                modal.show();
                
                if (message.status == 'NEW') {
                    const statusSelect = document.querySelector(`[data-id="${id}"]`);
                    if (statusSelect) {
                        statusSelect.value = 'read';
                        updateMessageStatus(statusSelect);
                    }
                }
            } else {
                showNotification('Error loading message', 'error');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showNotification('Error loading message', 'error');
        });
}

function replyMessage(id) {
    currentMessageId = id;
    
    fetch(contextPath + '/admin/messages/' + id)
        .then(response => response.json())
        .then(message => {
            if (message.success) {
                document.getElementById('replyMessageId').value = id;
                document.getElementById('replyToEmail').textContent = message.email;
                document.getElementById('replySubject').textContent = message.subject;
                document.getElementById('replyContent').value = '';
                
                const modal = new bootstrap.Modal(document.getElementById('replyMessageModal'));
                modal.show();
            } else {
                showNotification('Error loading message for reply', 'error');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showNotification('Error loading message for reply', 'error');
        });
}

function showReplyModal() {
    const viewModal = bootstrap.Modal.getInstance(document.getElementById('viewMessageModal'));
    if (viewModal) {
        viewModal.hide();
    }
    setTimeout(() => {
        replyMessage(currentMessageId);
    }, 300);
}

function deleteMessage(id) {
    if (confirm('Are you sure you want to delete this message? This action cannot be undone.')) {
        fetch(contextPath + '/admin/messages/delete/' + id, {
            method: 'DELETE'
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                showNotification('Message deleted successfully', 'success');
                location.reload();
            } else {
                showNotification('Failed to delete message', 'error');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showNotification('Error deleting message', 'error');
        });
    }
}

function markAllAsRead() {
    if (confirm('Mark all messages as read?')) {
        fetch(contextPath + '/admin/messages/mark-all-read', {
            method: 'POST'
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                showNotification('All messages marked as read', 'success');
                location.reload();
            } else {
                showNotification('Failed to mark messages as read', 'error');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showNotification('Error marking messages as read', 'error');
        });
    }
}

function deleteSelected() {
    const selectedIds = Array.from(document.querySelectorAll('.row-select:checked')).map(cb => cb.value);
    
    if (selectedIds.length == 0) {
        showNotification('Please select messages to delete', 'warning');
        return;
    }
    
    if (confirm(`Delete ${selectedIds.length} selected message(s)? This action cannot be undone.`)) {
        fetch(contextPath + '/admin/messages/delete-multiple', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ ids: selectedIds })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                showNotification(`${selectedIds.length} message(s) deleted successfully`, 'success');
                location.reload();
            } else {
                showNotification('Failed to delete selected messages', 'error');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showNotification('Error deleting selected messages', 'error');
        });
    }
}

function updateStatistics() {
    fetch(contextPath + '/admin/messages/statistics')
        .then(response => response.json())
        .then(stats => {
            if (stats.success) {
                document.getElementById('totalMessages').textContent = stats.total;
                document.getElementById('newMessages').textContent = stats.newCount;
                document.getElementById('inProgressMessages').textContent = stats.readCount;
                document.getElementById('repliedMessages').textContent = stats.repliedCount;
            }
        })
        .catch(error => {
            console.error('Error updating statistics:', error);
        });
}

function showNotification(message, type) {
    const notification = document.createElement('div');
    notification.className = `alert alert-${type == 'success' ? 'success' : type == 'warning' ? 'warning' : 'danger'} alert-dismissible fade show position-fixed`;
    notification.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
    notification.innerHTML = `
        <i class="fas fa-${type == 'success' ? 'check-circle' : type == 'warning' ? 'exclamation-triangle' : 'exclamation-circle'} me-2"></i>
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        if (notification.parentNode) {
            notification.remove();
        }
    }, 5000);
}
</script>

</body>
</html>