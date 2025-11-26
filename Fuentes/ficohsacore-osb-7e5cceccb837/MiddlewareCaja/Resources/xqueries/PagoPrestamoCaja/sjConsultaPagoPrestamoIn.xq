(:: pragma bea:global-element-parameter parameter="$sjConsultaPrestamo1" element="ns1:sjConsultaPrestamo" location="../../xsds/PagoPrestamoCaja/sjConsultaPrestamo.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultadepagodeprestamoAA" location="../../xsds/ConsultaGeneralPrestamo/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPrestamoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/sjConsultaSaldoPrestamoIn/";

declare function xf:sjConsultaSaldoPrestamoIn($sjConsultaPrestamo1 as element(ns1:sjConsultaPrestamo))
    as element(ns0:ConsultadepagodeprestamoAA) {
        <ns0:ConsultadepagodeprestamoAA>
            <WebRequestCommon>
                <userName>{ data($sjConsultaPrestamo1/USERNAME) }</userName>
                <password>{ data($sjConsultaPrestamo1/PASSWORD) }</password>
            </WebRequestCommon>
            <WSFICOPAYMENTDETAILSAAType>
                <enquiryInputCollection>
                    <columnName>ARRANGEMENT.ID</columnName>
                    <criteriaValue>{ data($sjConsultaPrestamo1/LOAN_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>PAYMENT.ID</columnName>
                    <criteriaValue>{ data($sjConsultaPrestamo1/TRANSACTION_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>                
            </WSFICOPAYMENTDETAILSAAType>
        </ns0:ConsultadepagodeprestamoAA>
};

declare variable $sjConsultaPrestamo1 as element(ns1:sjConsultaPrestamo) external;

xf:sjConsultaSaldoPrestamoIn($sjConsultaPrestamo1)