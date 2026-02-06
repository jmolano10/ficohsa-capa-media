xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaPrestamo1" element="ns1:sjConsultaPrestamo" location="../xsd/sjConsultaPrestamo.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadesaldodeprestamo" location="../../../consultaGeneralPrestamo/Resources/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPrestamoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/detalleMovimientosT24/consultarPagoPtmoAA/xq/sjConsultaDatosPrestamoIn/";

declare function xf:sjConsultaDatosPrestamoIn($sjConsultaPrestamo1 as element(ns1:sjConsultaPrestamo))
    as element(ns0:Consultadesaldodeprestamo) {
        <ns0:Consultadesaldodeprestamo>
            <WebRequestCommon>
                <userName>{ data($sjConsultaPrestamo1/USERNAME) }</userName>
                <password>{ data($sjConsultaPrestamo1/PASSWORD) }</password>
            </WebRequestCommon>
            <WSLOANDETAILSAAType>
                <enquiryInputCollection>
                    <columnName>ARRANGEMENT.ID</columnName>
                    <criteriaValue>{ data($sjConsultaPrestamo1/LOAN_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSLOANDETAILSAAType>
        </ns0:Consultadesaldodeprestamo>
};

declare variable $sjConsultaPrestamo1 as element(ns1:sjConsultaPrestamo) external;

xf:sjConsultaDatosPrestamoIn($sjConsultaPrestamo1)