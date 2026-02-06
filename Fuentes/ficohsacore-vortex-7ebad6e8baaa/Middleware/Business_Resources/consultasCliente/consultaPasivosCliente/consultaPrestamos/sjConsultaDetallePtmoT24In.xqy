xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:Consultadesaldodeprestamo" location="../../../consultaGeneralPrestamo/Resources/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaPrestamos/sjConsultaDetallePtmoT24In/";

declare function xf:sjConsultaDetallePtmoT24In($username as xs:string,
    $password as xs:string,
    $loanNumber as xs:string)
    as element(ns0:Consultadesaldodeprestamo) {
        <ns0:Consultadesaldodeprestamo>
            <WebRequestCommon>
                <userName>{ $username }</userName>
                <password>{ $password }</password>
            </WebRequestCommon>
            <WSLOANDETAILSAAType>
                <enquiryInputCollection>
                    <columnName>ARRANGEMENT.ID</columnName>
                    <criteriaValue>{ $loanNumber }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSLOANDETAILSAAType>
        </ns0:Consultadesaldodeprestamo>
};

declare variable $username as xs:string external;
declare variable $password as xs:string external;
declare variable $loanNumber as xs:string external;

xf:sjConsultaDetallePtmoT24In($username,
    $password,
    $loanNumber)