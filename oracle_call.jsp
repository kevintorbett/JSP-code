<%@ include file="validconn.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
        <head>
            <!--- <base REGION="main1"   class="wibble"> --->
            <LINK href="valid.css" rel="stylesheet" type="text/css">
        </head>
        <body>

            <TABLE CELLSPACING="0" CELLPADDING="0" BORDER="0" valign="bottom" bordercolor='black' bgcolor="lightgrey" WIDTH='100%'>

                <tr>
                    <form action='validcntry2.jsp' method='POST' name='validcntry2'>
                        <td></td>
                        <td></td>
                        <TD align="center"><font face=Verdana " size="-1 " color="black "><strong>REGION</TD> 
                        <TD align='left'><font face=Verdana" size="-1" color="black"><strong>TEXT</strong></TD>
                        <TD align='left'><font face=Verdana" size="-1" color="black"><strong>ABBR</strong></TD>
                        <TD align='left'></TD>
              </tr>

<%

Statement stmt = conn.createStatement();
String squery = "";
String action1 = request.getParameter("action1");
String cntryseq3 = request.getParameter("cntryseq");;

if ("Add".equals(action1) )
     {
	  String REGION_ID = request.getParameter("REGION_ID2");
    String REGION_ABBR2 = request.getParameter("REGION_ABBR");
		String userid = (String)session.getAttribute("adminid");
		String regiontext = request.getParameter("regiontext");
		String NOTES = request.getParameter("NOTES2");
	  String errors_yn = "N";

	       	squery = "select REGION_ABBR from VT_REGIONS where REGION_ABBR = '" + REGION_ABBR2 + "'";
			int rowcnt = 0;

			ResultSet rs6 = stmt.executeQuery(squery);
			while (rs6.next ())
			{
			rowcnt = (rowcnt + 1);
			}
			if (rowcnt > 0)
			{

				out.println( " <font face='Verdana' size='+2' color='#003366'>REGION Abbreviation already exists</font>"); errors_yn = "Y"; } 
        if (errors_yn == "N") 
        { try { CallableStatement oraStmt1 = conn.prepareCall("{ ? = call fn_add_vt_region (?,?,?,?,?)}"); 
        oraStmt1.setString(2,""); oraStmt1.setString(3,regiontext); 
        oraStmt1.setString(4,REGION_ABBR2); oraStmt1.setString(5,NOTES); 
        oraStmt1.setString(6,userid); 
        oraStmt1.registerOutParameter(1, oracle.jdbc.driver.OracleTypes.VARCHAR ); 
        oraStmt1.execute(); int rsie = oraStmt1.getInt (1); 
        if (rsie  < 0 )
          { 
          out.println( "<font face=Verdana size='-1' color='#003366'><strong>An ERROR has occurred - duplicate" + rsie ); } 
        else { 
          out.println( "<font face=Verdana size='-1' color='#003366'><strong>Added " ); 
          cntryseq3=String.valueOf(rsie); out.println( "<SCRIPT type='text/javascript'>"); 
          out.println( "<!--"); 
          out.println( "	parent.main3.window.location='validcntry.jsp'"); 
          out.println( "// -->"); 
          out.println( "</SCRIPT> "); } 
          } 
        catch(SQLException e) 
        { out.println( "SQLExceptionA: " + e.getMessage() + "<BR>"); 
        while((e=e .getNextException()) !=n ull) out.println(e.getMessage() + "<BR>"); } } } 
        
        
 if ( "Del".equals(action1) ) 
      { 
        String REGION_ID=request.getParameter( "REGION_ID2"); 
        String NOTES=r equest.getParameter( "NOTES2"); cntryseq3=c ntryseq3.trim(); 
        String userid=( String)session.getAttribute( "adminid"); 
        
        try { CallableStatement oraStmt1=c onn.prepareCall( "{ ? = call fn_del_vt_region   (?,?,?)}"); 
        oraStmt1.setString(2,REGION_ID); oraStmt1.setString(3,NOTES); 
        oraStmt1.setString(4,userid); 
        oraStmt1.registerOutParameter(1, oracle.jdbc.driver.OracleTypes.VARCHAR ); 
        oraStmt1.execute(); int rsie=o raStmt1.getInt (1); 
        if (rsie < 0 ){ if (rsie==-20012 )
        { out.println( "<font face=Verdana size='-1' color='#003366'><strong>ERROR - used in VT_FLAG_REGIONS " + rsie ); } 
        else { out.println( "<font face=Verdana size='-1' color='#003366'><strong>An ERROR has occurred = " + rsie ); } } 
        else { out.println( "<font face=Verdana size='-1' color='#003366'><strong>Deleted " ); cntryseq3="0" ; 
        out.println( "<SCRIPT type='text/javascript'>"); out.println( "<!--"); 
        out.println( "	parent.main3.window.location='validcntry.jsp'"); 
        out.println( "// -->"); 
        out.println( "</SCRIPT> "); } 
        } 
        catch(SQLException e) { 
        out.println( "SQLExceptionA: " + e.getMessage() + "<BR>"); while((e=e .getNextException()) !=null) 
        out.println(e.getMessage() + "<BR>"); } }



                                <TABLE CELLSPACING="0" CELLPADDING="0" BORDER="0" WIDTH='100%'>
                                    <tr>
                                        <TD COLSPAN='1' ALIGN='center'>
                                            <INPUT TYPE='button' style="font:bold 10pt Verdana;color:#f3f3f3; text-align:middle; background: green; border: 1px solid black;" NAME='SUBMIT' VALUE='ADD' onclick=GoMain( "Add")>
                                            <INPUT TYPE='button' style="font:bold 10pt Verdana;color:#f3f3f3; text-align:middle; background: #003366; border: 1px solid black;" NAME='SUBMIT' VALUE='DEL' onclick=go_there( "Del")>
                                        </TD>
                                        <INPUT TYPE=hidden NAME=delsw VALUE="N">
                                    </TR>
                                </TABLE>
                    </form>
                    </CENTER>
        </BODY>
        <SCRIPT type="text/javascript">
            function GoMain(type) {
                if (window.document.validcntry2.regiontext.value == '')
                {
                    var where_to = confirm("Please enter a TEXT description");
                    return false;
                }
                if (window.document.validcntry2.REGION_ABBR.value == '')
               {
                    var where_to = confirm("Please enter a ABBR");
                    return false;
                }
                parent.main4.document.validcntry2.action1.value = type;
                parent.main4.document.validcntry2.submit()
            }
            function Go() {
                parent.main4.document.validcntry2.action1.value = "";
                parent.main4.document.validcntry2.submit()
                document.forms['home'].submit();
                location = "validcntry2.jsp"
            }
            function go_del()
            {
                window.document.validcntry2.delsw.value = 'Y';
            }
            function go_there(type)
            {
                if (window.document.validcntry2.regiontext.value == '')
                {
                    var where_to = confirm("Please enter a TEXT description");
                    return false;
                }
                if (window.document.validcntry2.NOTES2.value == '')
                {
                    var where_to = confirm("Please enter a NOTES comment ");
                    return false;
                }
                if (window.document.validcntry2.VT_REGION_TXT_ATVID.value == '')
                { 
                    window.document.validcntry2.delsw.value = 'N';
                    return false;
                }
                var where_to = confirm("Do you really want to do this?");
                if (where_to == true)
                {
                    parent.main4.document.validcntry2.action1.value = type;
                    parent.main4.document.validcntry2.submit()
                } else
                {
                    window.document.validcntry2.delsw.value = 'N';
                    return false;
                }

            }

            //-->
        </script>

        </HTML>