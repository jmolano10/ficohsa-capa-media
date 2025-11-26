(:: pragma bea:global-element-parameter parameter="$consultadelimitesporclienteResponse" element="ns0:ConsultadelimitesporclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaLimitesClienteResponse" location="../Resources/consultaClientesTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaLimitesCliente/consultaLimitesClienteOut/";

declare function xf:consultaLimitesClienteOut($consultadelimitesporclienteResponse as element(ns0:ConsultadelimitesporclienteResponse))
    as element(ns1:consultaLimitesClienteResponse) {
        <ns1:consultaLimitesClienteResponse>
            {
                for $CUSTOMERNO in $consultadelimitesporclienteResponse/WSFICOLIMITSUMMARYType[1]/gWSFICOLIMITSUMMARYDetailType/mWSFICOLIMITSUMMARYDetailType[1]/CUSTOMERNO
                return
                    <CUSTOMER_ID>{ data($CUSTOMERNO) }</CUSTOMER_ID>
            }
            {
                for $CUSTOMERNAME in $consultadelimitesporclienteResponse/WSFICOLIMITSUMMARYType[1]/gWSFICOLIMITSUMMARYDetailType/mWSFICOLIMITSUMMARYDetailType[1]/CUSTOMERNAME
                return
                    <CUSTOMER_NAME>{ data($CUSTOMERNAME) }</CUSTOMER_NAME>
            }
            {
                for $CURRENCY in $consultadelimitesporclienteResponse/WSFICOLIMITSUMMARYType[1]/gWSFICOLIMITSUMMARYDetailType/mWSFICOLIMITSUMMARYDetailType[1]/CURRENCY
                return
                    <LIMIT_CURRENCY>{ data($CURRENCY) }</LIMIT_CURRENCY>
            }
            {
                for $TOTLIMITAMT in $consultadelimitesporclienteResponse/WSFICOLIMITSUMMARYType[1]/gWSFICOLIMITSUMMARYDetailType/mWSFICOLIMITSUMMARYDetailType[1]/TOTLIMITAMT
                return
                    <TOTAL_LIMIT>{ data($TOTLIMITAMT) }</TOTAL_LIMIT>
            }
            {
                for $TOTLIMITAMTLCY in $consultadelimitesporclienteResponse/WSFICOLIMITSUMMARYType[1]/gWSFICOLIMITSUMMARYDetailType/mWSFICOLIMITSUMMARYDetailType[1]/TOTLIMITAMTLCY
                return
                    <TOTAL_LIMIT_LCY>{ data($TOTLIMITAMTLCY) }</TOTAL_LIMIT_LCY>
            }
            {
                for $TOTREDULIMIT in $consultadelimitesporclienteResponse/WSFICOLIMITSUMMARYType[1]/gWSFICOLIMITSUMMARYDetailType/mWSFICOLIMITSUMMARYDetailType[1]/TOTREDULIMIT
                return
                    <TOTAL_REDU_LIMIT>{ data($TOTREDULIMIT) }</TOTAL_REDU_LIMIT>
            }
            {
                for $TOTREDULIMITLCY in $consultadelimitesporclienteResponse/WSFICOLIMITSUMMARYType[1]/gWSFICOLIMITSUMMARYDetailType/mWSFICOLIMITSUMMARYDetailType[1]/TOTREDULIMITLCY
                return
                    <TOTAL_REDU_LIMIT_LCY>{ data($TOTREDULIMITLCY) }</TOTAL_REDU_LIMIT_LCY>
            }
            {
                for $TOTREDUAVAIL in $consultadelimitesporclienteResponse/WSFICOLIMITSUMMARYType[1]/gWSFICOLIMITSUMMARYDetailType/mWSFICOLIMITSUMMARYDetailType[1]/TOTREDUAVAIL
                return
                    <AVAIL_REDU_LIMIT>{ data($TOTREDUAVAIL) }</AVAIL_REDU_LIMIT>
            }
            {
                for $TOTREAVALCY in $consultadelimitesporclienteResponse/WSFICOLIMITSUMMARYType[1]/gWSFICOLIMITSUMMARYDetailType/mWSFICOLIMITSUMMARYDetailType[1]/TOTREAVALCY
                return
                    <AVAIL_REDU_LIMIT_LCY>{ data($TOTREAVALCY) }</AVAIL_REDU_LIMIT_LCY>
            }
            {
                for $TOTNONREDULIMIT in $consultadelimitesporclienteResponse/WSFICOLIMITSUMMARYType[1]/gWSFICOLIMITSUMMARYDetailType/mWSFICOLIMITSUMMARYDetailType[1]/TOTNONREDULIMIT
                return
                    <TOTAL_NON_REDU_LIMIT>{ data($TOTNONREDULIMIT) }</TOTAL_NON_REDU_LIMIT>
            }
            {
                for $TOTNONREDLCY in $consultadelimitesporclienteResponse/WSFICOLIMITSUMMARYType[1]/gWSFICOLIMITSUMMARYDetailType/mWSFICOLIMITSUMMARYDetailType[1]/TOTNONREDLCY
                return
                    <TOTAL_NON_REDU_LIMIT_LCY>{ data($TOTNONREDLCY) }</TOTAL_NON_REDU_LIMIT_LCY>
            }
            {
                for $TOTNONREDUAVAIL in $consultadelimitesporclienteResponse/WSFICOLIMITSUMMARYType[1]/gWSFICOLIMITSUMMARYDetailType/mWSFICOLIMITSUMMARYDetailType[1]/TOTNONREDUAVAIL
                return
                    <AVAIL_NON_REDU_LIMIT>{ data($TOTNONREDUAVAIL) }</AVAIL_NON_REDU_LIMIT>
            }
            {
                for $TOTNONREAVALCY in $consultadelimitesporclienteResponse/WSFICOLIMITSUMMARYType[1]/gWSFICOLIMITSUMMARYDetailType/mWSFICOLIMITSUMMARYDetailType[1]/TOTNONREAVALCY
                return
                    <AVAIL_NON_REDU_LIMIT_LCY>{ data($TOTNONREAVALCY) }</AVAIL_NON_REDU_LIMIT_LCY>
            }
        </ns1:consultaLimitesClienteResponse>
};

declare variable $consultadelimitesporclienteResponse as element(ns0:ConsultadelimitesporclienteResponse) external;

xf:consultaLimitesClienteOut($consultadelimitesporclienteResponse)