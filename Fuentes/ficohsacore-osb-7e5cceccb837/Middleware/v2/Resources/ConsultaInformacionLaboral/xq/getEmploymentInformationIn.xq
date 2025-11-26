(:: pragma bea:global-element-parameter parameter="$consultaInformacionLaboralRequest" element="ns0:consultaInformacionLaboralRequest" location="../xsd/consultaInformacionLaboralTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaInformacionLaboralRequest" location="../../../BusinessServices/FPC/getEmploymentInformation12c/xsd/GetEmploymentInformation.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaInformacionLaboralTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaInformacionLaboral/xq/getEmploymentInformationIn/";

declare function local:formatDate($date as xs:string) as xs:string{
     let $finalDate := if(not(string-length($date) > 8))then (replace($date, "(\d{4})(\d{2})(\d{2})", "$1-$2-$3"))else($date)
     return
     fn-bea:date-to-string-with-format("dd/MM/yyyy",xs:date($finalDate))

};

declare function xf:getEmploymentInformationIn($consultaInformacionLaboralRequest as element(ns0:consultaInformacionLaboralRequest))
    as element(ns0:consultaInformacionLaboralRequest) {
        <ns0:consultaInformacionLaboralRequest>
            <ns0:CUSTOMER_ACCOUNT>{ data($consultaInformacionLaboralRequest/ns0:CUSTOMER_ACCOUNT) }</ns0:CUSTOMER_ACCOUNT>
            {
                for $FROM_DATE in $consultaInformacionLaboralRequest/ns0:FROM_DATE
                return
                    <ns0:FROM_DATE>{local:formatDate($FROM_DATE)}</ns0:FROM_DATE>
            }
            {
                for $TO_DATE in $consultaInformacionLaboralRequest/ns0:TO_DATE
                return
                    <ns0:TO_DATE>{local:formatDate($TO_DATE) }</ns0:TO_DATE>
            }
        </ns0:consultaInformacionLaboralRequest>
};

declare variable $consultaInformacionLaboralRequest as element(ns0:consultaInformacionLaboralRequest) external;

xf:getEmploymentInformationIn($consultaInformacionLaboralRequest)