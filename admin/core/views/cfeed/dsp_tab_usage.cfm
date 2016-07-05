<!--- This file is part of Mura CMS.

Mura CMS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, Version 2 of the License.

Mura CMS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Mura CMS. If not, see <http://www.gnu.org/licenses/>.

Linking Mura CMS statically or dynamically with other modules constitutes the preparation of a derivative work based on
Mura CMS. Thus, the terms and conditions of the GNU General Public License version 2 ("GPL") cover the entire combined work.

However, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with programs
or libraries that are released under the GNU Lesser General Public License version 2.1.

In addition, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with
independent software modules (plugins, themes and bundles), and to distribute these plugins, themes and bundles without
Mura CMS under the license of your choice, provided that you follow these specific guidelines:

Your custom code

• Must not alter any default objects in the Mura CMS database and
• May not alter the default display of the Mura CMS logo within Mura CMS and
• Must not alter any files in the following directories.

 /admin/
 /tasks/
 /config/
 /requirements/mura/
 /Application.cfc
 /index.cfm
 /MuraProxy.cfc

You may copy and distribute Mura CMS with a plug-in, theme or bundle that meets the above guidelines as a combined work
under the terms of GPL for Mura CMS, provided that you include the source code of that other code when and as the GNU GPL
requires distribution of source code.

For clarity, if you create a modified version of Mura CMS, you are not obligated to grant this special exception for your
modified version; it is your choice whether to do so, or to make such modified version available under the GNU General Public License
version 2 without this exception.  You may, if you choose, apply this exception to your own modified versions of Mura CMS.
--->

<cfsilent>
<cfset rsUsage=application.contentGateway.getUsage(rc.feedID) />
<cfparam name="rc.homeid" default="">
</cfsilent><cfoutput>
<cfset tabLabellist=listAppend(tabLabelList,application.rbFactory.getKeyValue(session.rb,'collections.usagereport')) >
<cfset tabList=listAppend(tabList,"tabUsagereport")>
<div id="tabUsagereport" class="tab-pane">

	<div class="block block-bordered">
		<!-- block header -->
		<div class="block-header">
			<h3 class="block-title">Usage Report</h3>
		</div> <!-- /.block header -->
		<div class="block-content">
			<div class="mura-control-group">
				    <cfif rsUsage.recordcount>
						<div class="mura-control justify">
						<label>#application.rbFactory.getKeyValue(session.rb,'collections.usagetext')#:</label>
						<table id="metadata" class="mura-table-grid">
					    <tr>
					      <th class="actions"></th>
					      <th class="var-width">#application.rbFactory.getKeyValue(session.rb,'collections.title')#</th>
					      <th>#application.rbFactory.getKeyValue(session.rb,'collections.display')#</th>
					      <th>#application.rbFactory.getKeyValue(session.rb,'collections.update')#</th>
					    </tr>
				     <cfloop query="rsUsage">
						<cfset crumbdata=application.contentManager.getCrumbList(rsUsage.contentid, rc.siteid)/>
						<cfset verdict=application.permUtility.getnodePerm(crumbdata)/>
				        <tr>
				          <td class="actions"><a class="show-actions" href="javascript:;" ontouch="this.onclick();" onclick="showTableControls(this);"><i class="mi-ellipsis-v"></i></a><div class="actions-menu"><ul class="actions-list"><cfif verdict neq 'none'><li class="edit"><a href="./?muraAction=cArch.edit&contenthistid=#rsUsage.ContentHistID#&contentid=#rsUsage.ContentID#&type=#rsUsage.type#&parentid=#rsUsage.parentID#&topid=#rsUsage.contentid#&siteid=#rsUsage.siteid#&moduleid=#rsUsage.moduleid#&compactDisplay=#esapiEncode('html',rc.compactDisplay)#&homeID=#esapiEncode('html',rc.homeID)#"><i class="mi-pencil"></i>#application.rbFactory.getKeyValue(session.rb,'collections.edit')#</a></li><li class="version-history"><a href="./?muraAction=cArch.hist&contentid=#rsUsage.ContentID#&type=#rsUsage.type#&parentid=#rsUsage.parentID#&topid=#rsUsage.contentid#&siteid=#rsUsage.siteid#&moduleid=#rsUsage.moduleid#"><i class="mi-history"></i>#application.rbFactory.getKeyValue(session.rb,'collections.versionhistory')#</a></li><cfelse><li class="edit disabled">#application.rbFactory.getKeyValue(session.rb,'collections.edit')#</li><li class="version-history disabled">#application.rbFactory.getKeyValue(session.rb,'collections.versionhistory')#</li></cfif></ul></div></td>
				          <td class="var-width">#$.dspZoom(crumbdata)#</td>
				          <td>
					    <cfif rsUsage.Display and (rsUsage.Display eq 1 and rsUsage.approved)>Yes<cfelseif(rsUsage.Display eq 2 and rsUsage.approved)>#LSDateFormat(rsUsage.displaystart,session.dateKeyFormat)# - #LSDateFormat(rsUsage.displaystop,session.dateKeyFormat)#<cfelse>No</cfif></td>
						<td>#LSDateFormat(rsUsage.lastupdate,session.dateKeyFormat)#</td>
				        </tr>
				       </cfloop>
				   		</table>
						</div>
				     <cfelse>
				      	<div class="help-block-empty"><cfif rc.feedBean.getType() eq 'Local'>#application.rbFactory.getKeyValue(session.rb,'collections.noindexusage')#<cfelse>#application.rbFactory.getKeyValue(session.rb,'collections.nofeedusage')#</cfif></div>
				    </cfif>
			 </div>

		</div> <!-- /.block-content -->
	</div> <!-- /.block-bordered -->
</div> <!-- /.tab-pane -->
</cfoutput>
