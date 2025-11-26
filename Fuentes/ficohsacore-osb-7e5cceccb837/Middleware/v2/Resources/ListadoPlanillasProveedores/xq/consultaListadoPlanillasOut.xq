(:: pragma bea:global-element-parameter parameter="$consultaListadoGrupoPlanillaResponse" element="ns0:ConsultaListadoGrupoPlanillaResponse" location="../../../../Business_Resources/listadoPlanillasProveedores/Resources/XMLSchema_596884079.xsd" ::)
(:: pragma bea:global-element-return element="ns1:listadoPlanillasProveedoresResponse" location="../xsd/listadoPlanillasProveedoresTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/listadoPlanillasProveedoresTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ListadoPlanillasProveedores/xq/consultaListadoPlanillasOut/";

declare function xf:consultaListadoPlanillasOut($consultaListadoGrupoPlanillaResponse as element(ns0:ConsultaListadoGrupoPlanillaResponse))
    as element(ns1:listadoPlanillasProveedoresResponse) {
        <ns1:listadoPlanillasProveedoresResponse>
            <ns1:listadoPlanillasProveedoresResponseType>
                {
                    for $mWSPAYROLLGROUPDetailType in $consultaListadoGrupoPlanillaResponse/WSPAYROLLGROUPType[1]/gWSPAYROLLGROUPDetailType/mWSPAYROLLGROUPDetailType
                    return
                        <ns1:listadoPlanillasProveedoresResponseRecordType>
                            {
                                for $CODID in $mWSPAYROLLGROUPDetailType/CODID
                                return
                                    <PAYROLL_GROUP_ID>{ data($CODID) }</PAYROLL_GROUP_ID>
                            }
                            {
                                for $COMPANYID in $mWSPAYROLLGROUPDetailType/COMPANYID
                                return
                                    <CONTRACT_ID>{ data($COMPANYID) }</CONTRACT_ID>
                            }
                            {
                                for $DESCRIPTION in $mWSPAYROLLGROUPDetailType/DESCRIPTION
                                return
                                    <CUSTOMER_NAME>{ data($DESCRIPTION) }</CUSTOMER_NAME>
                            }
                            {
                                for $GRPSTATUS in $mWSPAYROLLGROUPDetailType/GRPSTATUS
                                return
                                    <CURRENT_STATUS>{ data($GRPSTATUS) }</CURRENT_STATUS>
                            }
                            {
                                for $CUSTOMER in $mWSPAYROLLGROUPDetailType/CUSTOMER
                                return
                                    <CUSTOMER_CODE>{ data($CUSTOMER) }</CUSTOMER_CODE>
                            }
                            {
                                for $CASHADVFLAG in $mWSPAYROLLGROUPDetailType/CASHADVFLAG
                                return
                                    <CASH_ADVANCE_FLAG>{ data($CASHADVFLAG) }</CASH_ADVANCE_FLAG>
                            }
                        </ns1:listadoPlanillasProveedoresResponseRecordType>
                }
            </ns1:listadoPlanillasProveedoresResponseType>
        </ns1:listadoPlanillasProveedoresResponse>
};

declare variable $consultaListadoGrupoPlanillaResponse as element(ns0:ConsultaListadoGrupoPlanillaResponse) external;

xf:consultaListadoPlanillasOut($consultaListadoGrupoPlanillaResponse)
