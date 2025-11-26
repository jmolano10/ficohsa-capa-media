(:: pragma bea:global-element-return element="ns0:ConsultaDAO" location="../../xsds/Core/XMLSchema_1632682327.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaDAO/consultaDAOIn/";

declare function xf:consultaDAOIn($username as xs:string,
    $password as xs:string,
    $DAO as xs:string,
    $deptLevel as xs:string)
    as element(ns0:ConsultaDAO) {
        <ns0:ConsultaDAO>
            <WebRequestCommon>
                <userName>{ $username }</userName>
                <password>{ $password }</password>
            </WebRequestCommon>
            <WSADMINDEPTACCTOFFICERType>
            {
            	if ($DAO != "") then ( 
                <enquiryInputCollection>
                	<columnName>@ID</columnName>
                    <criteriaValue>{ $DAO }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
               	) else (),
               	if ($deptLevel != "") then ( 
                <enquiryInputCollection>
                	<columnName>DEPT.LEVEL</columnName>
                    <criteriaValue>{ $deptLevel }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
               	) else ()
            }
            </WSADMINDEPTACCTOFFICERType>
        </ns0:ConsultaDAO>
};

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $DAO as xs:string external;
declare variable $deptLevel as xs:string external;

xf:consultaDAOIn($username,
    $password,
    $DAO,
    $deptLevel)