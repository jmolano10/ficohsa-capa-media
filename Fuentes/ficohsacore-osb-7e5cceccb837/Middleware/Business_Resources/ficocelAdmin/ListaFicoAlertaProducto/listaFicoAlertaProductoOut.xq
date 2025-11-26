(:: pragma bea:global-element-parameter parameter="$listadeFicoAlertasporproductoResponse" element="ns0:ListadeFicoAlertasporproductoResponse" location="../Resources/XMLSchema_1876963756.xsd" ::)
(:: pragma bea:global-element-return element="ns1:listaFicoAlertaProductoResponse" location="listaFicoAlertaProductoTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/listaFicoAlertaProductoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ficocelAdmin/ListaFicoAlertaProducto/listaFicoAlertaProductoOut/";

declare function xf:listaFicoAlertaProductoOut($listadeFicoAlertasporproductoResponse as element(ns0:ListadeFicoAlertasporproductoResponse))
    as element(ns1:listaFicoAlertaProductoResponse) {
        <ns1:listaFicoAlertaProductoResponse>
            {
                for $gWSACCOUNTALERTSDetailType in $listadeFicoAlertasporproductoResponse/WSACCOUNTALERTSType[1]/gWSACCOUNTALERTSDetailType
                return
                    <ns1:listaFicoAlertaProductoResponseType>
                        {
                            for $mWSACCOUNTALERTSDetailType in $gWSACCOUNTALERTSDetailType/mWSACCOUNTALERTSDetailType
                            return
                                <ns1:listaFicoAlertaProductoResponseRecordType>
                                    {
                                        for $ID in $mWSACCOUNTALERTSDetailType/ID
                                        return
                                            <SUBSCRIPTION_ID>{ data($ID) }</SUBSCRIPTION_ID>
                                    }
                                    {
                                        for $EVENT in $mWSACCOUNTALERTSDetailType/EVENT
                                        return
                                            <EVENT>{ data($EVENT) }</EVENT>
                                    }
                                    {
                                        for $PRODUCTID in $mWSACCOUNTALERTSDetailType/PRODUCTID
                                        return
                                            <PRODUCT_ID>{ data($PRODUCTID) }</PRODUCT_ID>
                                    }
                                    {
                                        for $SUBSCRIBED in $mWSACCOUNTALERTSDetailType/SUBSCRIBED
                                        return
                                            <ACTIVE_ALERT>{ data($SUBSCRIBED) }</ACTIVE_ALERT>
                                    }
                                </ns1:listaFicoAlertaProductoResponseRecordType>
                        }
                    </ns1:listaFicoAlertaProductoResponseType>
            }
        </ns1:listaFicoAlertaProductoResponse>
};

declare variable $listadeFicoAlertasporproductoResponse as element(ns0:ListadeFicoAlertasporproductoResponse) external;

xf:listaFicoAlertaProductoOut($listadeFicoAlertasporproductoResponse)