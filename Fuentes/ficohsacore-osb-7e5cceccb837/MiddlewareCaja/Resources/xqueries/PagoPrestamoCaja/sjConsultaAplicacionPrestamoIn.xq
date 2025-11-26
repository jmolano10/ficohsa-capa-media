(:: pragma bea:global-element-parameter parameter="$sjConsultaPrestamo1" element="ns1:sjConsultaPrestamo" location="../../xsds/PagoPrestamoCaja/sjConsultaPrestamo.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultaaplicacionpagoptmo" location="../../xsds/ConsultaGeneralPrestamo/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPrestamoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/sjConsultaAplicacionPrestamoIn/";

declare function xf:sjConsultaAplicacionPrestamoIn($sjConsultaPrestamo1 as element(ns1:sjConsultaPrestamo))
    as element(ns0:Consultaaplicacionpagoptmo) {
        <ns0:Consultaaplicacionpagoptmo>
            <WebRequestCommon>
                <userName>{ data($sjConsultaPrestamo1/USERNAME) }</userName>
                <password>{ data($sjConsultaPrestamo1/PASSWORD) }</password>
            </WebRequestCommon>
            <WSFICOADVDEALSLIPENTRYType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ data($sjConsultaPrestamo1/LOAN_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
                <enquiryInputCollection>
                    <columnName>ADV.REF</columnName>
                    <criteriaValue>{ data($sjConsultaPrestamo1/TRANSACTION_ID) }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>                
            </WSFICOADVDEALSLIPENTRYType>
        </ns0:Consultaaplicacionpagoptmo>
};

declare variable $sjConsultaPrestamo1 as element(ns1:sjConsultaPrestamo) external;

xf:sjConsultaAplicacionPrestamoIn($sjConsultaPrestamo1)