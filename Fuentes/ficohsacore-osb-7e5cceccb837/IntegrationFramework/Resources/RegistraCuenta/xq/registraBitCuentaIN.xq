(:: pragma bea:global-element-parameter parameter="$EntradaCta" element="ns0:InputParameters" location="../../../BusinessServices/RegistraCuentaTSPDB/xsd/TSP_CREA_CUENTA_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$SalidaCta" element="ns0:OutputParameters" location="../../../BusinessServices/RegistraCuentaTSPDB/xsd/TSP_CREA_CUENTA_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/InsertaBitacoraTSPDB/xsd/T24InsertBitacoraTSPDB_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/T24InsertBitacoraTSPDB";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/TSP_CREA_CUENTA";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/RegistraCuenta/xq/registraBitCuentaIN/";

declare function xf:registraBitCuentaIN($EntradaCta as element(ns0:InputParameters),
    $SalidaCta as element(ns0:OutputParameters))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_EVENTO>T24NewAccount</ns1:PV_EVENTO>
            {
                for $PV_ID_CLIENTE in $EntradaCta/ns0:PV_ID_CLIENTE
                return
                    <ns1:PV_ID_CLIENTE>{ data($PV_ID_CLIENTE) }</ns1:PV_ID_CLIENTE>
            }
            {
                for $PV_ID_CUENTA in $EntradaCta/ns0:PV_ID_CUENTA
                return
                    <ns1:PV_ID_CUENTA>{ data($PV_ID_CUENTA) }</ns1:PV_ID_CUENTA>
            }
            {
                for $PV_CATEGORIA in $EntradaCta/ns0:PV_CATEGORIA,
                    $PV_NOMBRE_CUENTA in $EntradaCta/ns0:PV_NOMBRE_CUENTA,
                    $PV_ID_MONEDA in $EntradaCta/ns0:PV_ID_MONEDA,
                    $PV_ID_GRUPO_PLANILLA in $EntradaCta/ns0:PV_ID_GRUPO_PLANILLA
                return
                    <ns1:PV_DATOS>{ concat($PV_CATEGORIA," - " , $PV_NOMBRE_CUENTA," - " , $PV_ID_MONEDA," - " , $PV_ID_GRUPO_PLANILLA) }</ns1:PV_DATOS>
            }
            {
                for $PV_COD_RSPTA in $SalidaCta/ns0:PV_COD_RSPTA
                return
                    <ns1:PV_SUSSCES_INDICADOR>{ data($PV_COD_RSPTA) }</ns1:PV_SUSSCES_INDICADOR>
            }
            {
                for $PV_DES_RSPTA in $SalidaCta/ns0:PV_DES_RSPTA
                return
                    <ns1:PV_MENSAJE>{ data($PV_DES_RSPTA) }</ns1:PV_MENSAJE>
            }
        </ns1:InputParameters>
};

declare variable $EntradaCta as element(ns0:InputParameters) external;
declare variable $SalidaCta as element(ns0:OutputParameters) external;

xf:registraBitCuentaIN($EntradaCta,
    $SalidaCta)
