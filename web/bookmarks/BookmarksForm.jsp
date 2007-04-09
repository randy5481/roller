<%@ include file="/taglibs.jsp" %><%@ include file="/theme/header.jsp" %>

<%-- JavaScript for bookmarks table --%> 
<script type="text/javascript">
<!-- 
function setChecked(val) 
{
    len = document.bookmarksForm.elements.length;
    var i=0;
    for( i=0 ; i<len ; i++) 
    {
        document.bookmarksForm.elements[i].checked=val;
    }
}
function onDelete() 
{
    if ( confirm("Delete selected bookmarks?") ) 
    {
        document.bookmarksForm.method.value = "deleteSelected";
        document.bookmarksForm.submit();
    }
 }
function onMove() 
{
    if ( confirm("Move selected bookmarks?") ) 
    {
        document.bookmarksForm.method.value = "moveSelected";
        document.bookmarksForm.submit();
    }
}
//-->
</script>

<h1>
    <fmt:message key="bookmarksForm.folder" />:&nbsp;
    <c:if test="${empty folder}">
        <fmt:message key="bookmarksForm.root" />
    </c:if>
    <c:if test="${!(empty folder)}">
        <c:out value="${folder.name}" />
    </c:if>
</h1>

<%-- Folder path --%>

<p>
<b><fmt:message key="bookmarksForm.path" /></b>:

<c:if test="${empty folderPath}">
   /
   <roller:link page="/editor/bookmarks.do">
       <roller:linkparam id="method" value="selectFolder" />
       <fmt:message key="bookmarksForm.root" />
   </roller:link>
</c:if>

<c:if test="${!(empty folderPath)}">
    <c:forEach var="folder" items="${folderPath}">
        /
        <roller:link page="/editor/bookmarks.do">
            <roller:linkparam id="method" value="selectFolder" />
            <roller:linkparam 
                id="<%= RollerRequest.FOLDERID_KEY %>" 
                name="folder" property="id" />
            <c:out value="${folder.name}" />
        </roller:link>
    </c:forEach>
    <br />
</c:if>
</p>

<%-- Form is a table of folders followed by bookmarks, each with checkbox --%>

<html:form action="/editor/bookmarks" method="post">
<input type="hidden" name="method" /> 
<html:hidden property="folderId" /> 

<p>
<%-- Add Bookmark link --%>
<img src='<c:url value="/images/BookmarkNew16.png"/>' border="0"alt="icon" />
<roller:link page="/editor/bookmarkEdit.do">
    <roller:linkparam id="<%= RollerRequest.FOLDERID_KEY %>"
        name="folder" property="id" />
    <fmt:message key="bookmarksForm.addBookmark" />
</roller:link>

&nbsp;|&nbsp;

<%-- Add Folder link --%>
<img src='<c:url value="/images/FolderNew16.png"/>' border="0"alt="icon" />
<roller:link page="/editor/folderEdit.do">
    <roller:linkparam id="<%= RollerRequest.PARENTID_KEY %>"
         name="folder" property="id" />
    <fmt:message key="bookmarksForm.addFolder" />
</roller:link>
</p>

<p>
<%-- Select-all button --%>
<input type="button" value="<fmt:message key='bookmarksForm.checkAll' />" 
   onclick="setChecked(1)" /></input>

<%-- Select-none button --%>
<input type="button" value="<fmt:message key='bookmarksForm.checkNone' />" 
   onclick="setChecked(0)" /></input>

<%-- Delete-selected button --%>
<input type="button" value="<fmt:message key='bookmarksForm.delete' />" 
   onclick="onDelete()"/></input>
</td>
</p>

<table class="rollertable">

    <tr class="rHeaderTr">
        <th class="rollertable" width="5%">&nbsp;</th>
        <th class="rollertable" width="5%">&nbsp;</th>
        <th class="rollertable" width="30%"><fmt:message key="bookmarksForm.name" /></th>
        <th class="rollertable" width="50%"><fmt:message key="bookmarksForm.description" /></th>
        <th class="rollertable" width="5%"><fmt:message key="bookmarksForm.edit" /></th>
        <th class="rollertable" width="5%"><fmt:message key="bookmarksForm.visitLink" /></th>
    </tr>

    <%-- Folders --%>
    <c:forEach var="folder" items="${folders}" >
        <roller:row oddStyleClass="rollertable_odd" evenStyleClass="rollertable_even">

            <td class="rollertable">
                <html:multibox property="selectedFolders">
                    <c:out value="${folder.id}" />
                </html:multibox>
            </td>


            <td class="rollertable" align="center"><img src='<c:url value="/images/Folder16.png"/>' alt="icon" /></td>
            
            <td class="rollertable">
               <roller:link page="/editor/bookmarks.do">
                   <roller:linkparam id="method" value="selectFolder" />
                   <roller:linkparam 
                       id="<%= RollerRequest.FOLDERID_KEY %>" 
                       name="folder" property="id" />
                   <str:truncateNicely lower="15" upper="20" ><c:out value="${folder.name}" /></str:truncateNicely>
               </roller:link>
            </td>

            <td class="rollertable">
                <str:truncateNicely lower="30" upper="35" ><c:out value="${folder.description}" /></str:truncateNicely>
            </td>

            <td class="rollertable" align="center">
               <roller:link page="/editor/folderEdit.do">
                   <roller:linkparam 
                       id="<%= RollerRequest.FOLDERID_KEY %>" 
                       name="folder" property="id" />
                   <img src='<c:url value="/images/Edit16.png"/>' border="0" alt="icon" />
               </roller:link>
            </td>

            <td class="rollertable">&nbsp;</td>

        </roller:row>
    </c:forEach>

    <%-- Bookmarks --%>
    <c:forEach var="bookmark" items="${bookmarks}" >
        <roller:row oddStyleClass="rollertable_odd" evenStyleClass="rollertable_even">

            <td class="rollertable">
                <html:multibox property="selectedBookmarks">
                    <c:out value="${bookmark.id}" />
                </html:multibox>
            </td>

            <td class="rollertable" align="center"><img src='<c:url value="/images/Bookmark16.png"/>' alt="icon" /></td>
            
            <td class="rollertable">
                <str:truncateNicely lower="15" upper="20" ><c:out value="${bookmark.name}" /></str:truncateNicely>
            </td>

            <td class="rollertable">
                <str:truncateNicely lower="30" upper="35" ><c:out value="${bookmark.description}" /></str:truncateNicely>
            </td>

            <td class="rollertable" align="center">
               <roller:link page="/editor/bookmarkEdit.do">
                   <roller:linkparam 
                       id="<%= RollerRequest.BOOKMARKID_KEY %>" 
                       name="bookmark" property="id" />                   
                   <img src='<c:url value="/images/Edit16.png"/>' border="0" alt="icon" 
                       title="<fmt:message key='bookmarksForm.edit.tip' />" />
               </roller:link>
            </td>

            <td class="rollertable" align="center">
                <c:if test="${!empty bookmark.url}" >
                   <a href="<c:out value='${bookmark.url}'/>">
                       <img src='<c:url value="/images/WebVisit16.png"/>' border="0" alt="icon" 
                           title="<fmt:message key='bookmarksForm.visitLink.tip' />" />
                   </a>
                </c:if>
            </td>

        </roller:row>
    </c:forEach>

</table>

<p>
<%-- Move-selected button --%>
<input type="button" value="<fmt:message key='bookmarksForm.move' />"   
   onclick="onMove()"/></input>

<%-- Move-to combo-box --%>
<html:select property="moveToFolderId" size="1">
    <html:options collection="allFolders" 
        property="id" labelProperty="path"/>
</html:select>
</p>

</html:form>

<%@ include file="/theme/footer.jsp" %>