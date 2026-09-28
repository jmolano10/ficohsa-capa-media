(:: pragma bea:global-element-parameter parameter="$sjConsultaPrestamo1" element="ns1:sjConsultaPrestamo" location="../xsd/sjConsultaPrestamo.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultabackofficepagoptmoAA" location="../../../consultaGeneralPrestamo/Resources/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPrestamoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/detalleMovimientosT24/consultarPagoPtmoAA/xq/sjConsultaPagoPrestamoBOIn/";

declare function xf:sjConsultaPagoPrestamoBOIn($sjConsultaPrestamo1 as element(ns1:sjConsultaPrestamo))
    as element(ns0:ConsultabackofficepagoptmoAA) {
        <ns0:ConsultabackofficepagoptmoAA>
            <WebRequestCommon>
                <userName>{ data($sjConsultaPrestamo1/USERNAME) }</userName>
                <password>{ data($sjConsultaPrestamo1/PASSWORD) }</password>
            </WebRequestCommon>
            <WSFICOBOPAYMENTDETAILSType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($sjConsultaPrestamo1/TRANSACTION_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSFICOBOPAYMENTDETAILSType>
        </ns0:ConsultabackofficepagoptmoAA>
};

declare variable $sjConsultaPrestamo1 as element(ns1:sjConsultaPrestamo) external;

xf:sjConsultaPagoPrestamoBOIn($sjConsultaPrestamo1)