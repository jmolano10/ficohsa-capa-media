(:: pragma bea:global-element-parameter parameter="$actualizaciondeDatosClienteResponseIN" element="ns0:ActualizaciondeDatosClienteResponse" location="../../../BusinessServices/T24/actualizaDatosCliente/xsd/XMLSchema_1014999265.xsd" ::)
(:: pragma bea:global-element-return element="ns1:actualizaDatosClienteResponse" location="../xsd/actualizacionDatosCliente.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizaDatosClienteTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaDatosCliente/xq/actualizaDatosClienteOut/";

declare function xf:actualizaDatosClienteOut($CostumerCode as xs:string,
    $actualizaciondeDatosClienteResponseIN as element(ns0:ActualizaciondeDatosClienteResponse))
    as element(ns1:actualizaDatosClienteResponse) {
        <ns1:actualizaDatosClienteResponse>
            <CUSTOMER_ID>{ $CostumerCode }</CUSTOMER_ID>
            {
                for $gADDRESS.TYPE in $actualizaciondeDatosClienteResponseIN/CUSTOMERType/gADDRESS.TYPE
                return
                    <ADDRESS_INFO>
                        {
                            for $mADDRESS.TYPE in $gADDRESS.TYPE/mADDRESS.TYPE
                            return
                                <ADDRESS_ITEM>
                                    {
                                        for $ADDRESSTYPE in $mADDRESS.TYPE/ADDRESSTYPE
                                        return
                                            <ADDRESS_TYPE>{ fn:tokenize(data($ADDRESSTYPE), "!!") }</ADDRESS_TYPE>
                                    }
                                    {
                                        for $COMPLETEADDRES in $mADDRESS.TYPE/COMPLETEADDRES
                                        return
                                            <ADDRESS_LINE_1>{ fn:tokenize(data($COMPLETEADDRES), "!!") }</ADDRESS_LINE_1>
                                    }
                                    {
                                        for $COMPLETADDRESS in $mADDRESS.TYPE/COMPLETADDRESS
                                        return
                                            <ADDRESS_LINE_2>{ fn:tokenize(data($COMPLETADDRESS), "!!") }</ADDRESS_LINE_2>
                                    }
                                    {
                                        for $MAINADPHYCOR in $mADDRESS.TYPE/MAINADPHYCOR
                                        return
                                            <IS_MAIN_ADDRESS>{ fn:tokenize(data($MAINADPHYCOR), "!!") }</IS_MAIN_ADDRESS>
                                    }
                                </ADDRESS_ITEM>
                        }
                    </ADDRESS_INFO>
            }
        </ns1:actualizaDatosClienteResponse>
};

declare variable $CostumerCode as xs:string external;
declare variable $actualizaciondeDatosClienteResponseIN as element(ns0:ActualizaciondeDatosClienteResponse) external;

xf:actualizaDatosClienteOut($CostumerCode,
    $actualizaciondeDatosClienteResponseIN)