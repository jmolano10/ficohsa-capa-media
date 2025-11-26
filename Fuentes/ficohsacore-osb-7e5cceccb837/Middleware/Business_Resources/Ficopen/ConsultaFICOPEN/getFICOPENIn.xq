(:: pragma bea:global-element-parameter parameter="$consultaFICOPEN" element="ns0:consultaFICOPEN" location="consultaFICOPENTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaFICOPEN" location="../../../v2/BusinessServices/FPC/getFicopen12c/xsd/GetFicopenTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaFICOPENTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/Ficopen/ConsultaFICOPEN/getFICOPENIn/";

declare function xf:getFICOPENIn($consultaFICOPEN as element(ns0:consultaFICOPEN))
    as element(ns0:consultaFICOPEN) {
        <ns0:consultaFICOPEN>
            <INVESTMENT_CODE>{ data($consultaFICOPEN/INVESTMENT_CODE) }</INVESTMENT_CODE>
            <START_DATE>{ data($consultaFICOPEN/START_DATE) }</START_DATE>
            <END_DATE>{ data($consultaFICOPEN/END_DATE) }</END_DATE>
        </ns0:consultaFICOPEN>
};

declare variable $consultaFICOPEN as element(ns0:consultaFICOPEN) external;

xf:getFICOPENIn($consultaFICOPEN)
