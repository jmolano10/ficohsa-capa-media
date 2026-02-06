xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$obtenerSerializadoResponse1" element="tmp:ObtenerSerializadoResponse" location="../../../BusinessServices/VisionPlusHN/obtenerSerializado/xsd/bfemEECCHistorico.xsd" ::)
(:: pragma bea:global-element-return element="ns0:generaEstadoCuentaTCResponse" location="../../GeneraEstadoCuenta/xsd/generaEstadoCuentaTypes.xsd" ::)

declare namespace ns1 = "http://schemas.datacontract.org/2004/07/BF.Tarjetas.bfemEstadosCuentas.DataContracts";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/generaEstadoCuentaTypes";
declare namespace tmp = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraEstadoCuentaTCHN/xq/obtenerSerializadoHNOut/";

declare function xf:obtenerSerializadoHNOut($obtenerSerializadoResponse1 as element(tmp:ObtenerSerializadoResponse))
    as element(ns0:generaEstadoCuentaTCResponse) {
        <ns0:generaEstadoCuentaTCResponse>
            {
                for $NumeroTarjeta in $obtenerSerializadoResponse1/tmp:ObtenerSerializadoResult/ns1:NumeroTarjeta
                return
                    <CARD_NUMBER>{ data($NumeroTarjeta) }</CARD_NUMBER>
            }
            {
                for $NumeroCuenta in $obtenerSerializadoResponse1/tmp:ObtenerSerializadoResult/ns1:NumeroCuenta
                return
                    <ACCOUNT_NUMBER>{ data($NumeroCuenta) }</ACCOUNT_NUMBER>
            }
            <MONTH>{ substring(data($obtenerSerializadoResponse1/tmp:ObtenerSerializadoResult/ns1:Periodo),5,2) }</MONTH>
            <YEAR>{ substring(data($obtenerSerializadoResponse1/tmp:ObtenerSerializadoResult/ns1:Periodo),1,4) }</YEAR>
            <FILE_EXTRACT>{ data($obtenerSerializadoResponse1/tmp:ObtenerSerializadoResult/ns1:File) }</FILE_EXTRACT>
            <FILE_EXTENSION>{ data($obtenerSerializadoResponse1/tmp:ObtenerSerializadoResult/ns1:Extension) }</FILE_EXTENSION>
        </ns0:generaEstadoCuentaTCResponse>
};

declare variable $obtenerSerializadoResponse1 as element(tmp:ObtenerSerializadoResponse) external;

xf:obtenerSerializadoHNOut($obtenerSerializadoResponse1)