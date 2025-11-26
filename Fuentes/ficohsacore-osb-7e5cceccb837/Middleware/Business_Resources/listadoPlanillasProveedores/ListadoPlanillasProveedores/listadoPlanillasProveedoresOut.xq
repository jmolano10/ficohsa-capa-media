(:: pragma bea:global-element-parameter parameter="$consultadeplanillasResponse1" element="ns0:ConsultadeplanillasResponse" location="../Resources/XMLSchema_596884079.xsd" ::)
(:: pragma bea:global-element-return element="ns1:listadoPlanillasProveedoresResponse" location="listadoPlanillasProveedoresTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/listadoPlanillasProveedoresTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/listadoPlanillasProveedores/ListadoPlanillasProveedores/listadoPlanillasProveedoresOut/";

declare function xf:listadoPlanillasProveedoresOut($consultadeplanillasResponse1 as element(ns0:ConsultadeplanillasResponse))
    as element(ns1:listadoPlanillasProveedoresResponse) {
        <ns1:listadoPlanillasProveedoresResponse>
            <ns1:listadoPlanillasProveedoresResponseType>
                {
                    for $mLATAMAGPAYROLLGRPLISTDetailType in $consultadeplanillasResponse1/LATAMAGPAYROLLGRPLISTType[1]/gLATAMAGPAYROLLGRPLISTDetailType/mLATAMAGPAYROLLGRPLISTDetailType
                    return
                        <ns1:listadoPlanillasProveedoresResponseRecordType>
                            {
                                for $ID in $mLATAMAGPAYROLLGRPLISTDetailType/ID
                                return
                                    <PAYROLL_GROUP_ID>{ data($ID) }</PAYROLL_GROUP_ID>
                            }
                            {
                                for $COMPANYID in $mLATAMAGPAYROLLGRPLISTDetailType/COMPANYID
                                return
                                    <CONTRACT_ID>{ data($COMPANYID) }</CONTRACT_ID>
                            }
                            {
                                for $DESCRIPTION in $mLATAMAGPAYROLLGRPLISTDetailType/DESCRIPTION
                                return
                                    <CUSTOMER_NAME>{ data($DESCRIPTION) }</CUSTOMER_NAME>
                            }
                        </ns1:listadoPlanillasProveedoresResponseRecordType>
                }
            </ns1:listadoPlanillasProveedoresResponseType>
        </ns1:listadoPlanillasProveedoresResponse>
};

declare variable $consultadeplanillasResponse1 as element(ns0:ConsultadeplanillasResponse) external;

xf:listadoPlanillasProveedoresOut($consultadeplanillasResponse1)