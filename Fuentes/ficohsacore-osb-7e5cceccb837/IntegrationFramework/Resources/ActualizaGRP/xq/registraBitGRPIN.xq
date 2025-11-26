(:: pragma bea:global-element-parameter parameter="$EntradaActGRP" element="ns0:InputParameters" location="../../../BusinessServices/ActualizaGRPTSPDB/xsd/T24UpdateGRPDB_sp.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$SalidaActGRP" element="ns0:OutputParameters" location="../../../BusinessServices/ActualizaGRPTSPDB/xsd/T24UpdateGRPDB_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/InsertaBitacoraTSPDB/xsd/T24InsertBitacoraTSPDB_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/T24InsertBitacoraTSPDB";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/T24UpdateGRPDB";
declare namespace xf = "http://tempuri.org/IntegrationFramework/Resources/ActualizaGRP/xq/registraBitGRPIN/";

declare function xf:registraBitGRPIN($EntradaActGRP as element(ns0:InputParameters),
    $SalidaActGRP as element(ns0:OutputParameters))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_EVENTO>T24UpdateGRP</ns1:PV_EVENTO>
            {
                for $PV_ID_CUENTA in $EntradaActGRP/ns0:PV_ID_CUENTA
                return
                    <ns1:PV_ID_CUENTA>{ data($PV_ID_CUENTA) }</ns1:PV_ID_CUENTA>
            }
            {
                for $PV_ID_GRUPO_PLANILLA in $EntradaActGRP/ns0:PV_ID_GRUPO_PLANILLA
                return
                    <ns1:PV_DATOS>{ data($PV_ID_GRUPO_PLANILLA) }</ns1:PV_DATOS>
            }
            {
                for $PV_COD_RSPTA in $SalidaActGRP/ns0:PV_COD_RSPTA
                return
                    <ns1:PV_SUSSCES_INDICADOR>{ data($PV_COD_RSPTA) }</ns1:PV_SUSSCES_INDICADOR>
            }
            {
                for $PV_DES_RSPTA in $SalidaActGRP/ns0:PV_DES_RSPTA
                return
                    <ns1:PV_MENSAJE>{ data($PV_DES_RSPTA) }</ns1:PV_MENSAJE>
            }
        </ns1:InputParameters>
};

declare variable $EntradaActGRP as element(ns0:InputParameters) external;
declare variable $SalidaActGRP as element(ns0:OutputParameters) external;

xf:registraBitGRPIN($EntradaActGRP,
    $SalidaActGRP)
