(:: pragma bea:global-element-parameter parameter="$obtenerSerializadoResponse" element="ns0:ObtenerSerializadoResponse" location="../../../BusinessServices/VisionPlusREG/obtenerSerializado/xsd/bfemEECCHistorico.xsd" ::)
(:: pragma bea:global-element-return element="ns1:generaEstadoCuentaTCResponse" location="../../GeneraEstadoCuenta/xsd/generaEstadoCuentaTypes.xsd" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace ns2 = "http://schemas.datacontract.org/2004/07/BF.Tarjetas.bfemEstadosCuentas.DataContracts";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/generaEstadoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GeneraEstadoCuentaTC/xq/obtenerSerializadoHNOut/";

declare function xf:obtenerSerializadoHNOut($obtenerSerializadoResponse as element(ns0:ObtenerSerializadoResponse))
    as element(ns1:generaEstadoCuentaTCResponse) {
        <ns1:generaEstadoCuentaTCResponse>
            {
                for $NumeroTarjeta in $obtenerSerializadoResponse/ns0:ObtenerSerializadoResult/ns2:NumeroTarjeta
                return
                    <CARD_NUMBER>{ data($NumeroTarjeta) }</CARD_NUMBER>
            }
            {
                for $NumeroCuenta in $obtenerSerializadoResponse/ns0:ObtenerSerializadoResult/ns2:NumeroCuenta
                return
                    <ACCOUNT_NUMBER>{ data($NumeroCuenta) }</ACCOUNT_NUMBER>
            }
            {
                for $Periodo in $obtenerSerializadoResponse/ns0:ObtenerSerializadoResult/ns2:Periodo
                return
                    <MONTH>{ fn:substring(data($Periodo),5,2) }</MONTH>
            }
            {
                for $Periodo in $obtenerSerializadoResponse/ns0:ObtenerSerializadoResult/ns2:Periodo
                return
                    <YEAR>{ fn:substring(data($Periodo),1,4) }</YEAR>
            }
            {
                for $File in $obtenerSerializadoResponse/ns0:ObtenerSerializadoResult/ns2:File
                return
                    <FILE_EXTRACT>{ data($File) }</FILE_EXTRACT>
            }
            {
                for $Extension in $obtenerSerializadoResponse/ns0:ObtenerSerializadoResult/ns2:Extension
                return
                    <FILE_EXTENSION>{ data($Extension) }</FILE_EXTENSION>
            }
            {
                for $FileUrl in $obtenerSerializadoResponse/ns0:ObtenerSerializadoResult/ns2:FileUrl
                return
                    <FILE_LINK>{ data($FileUrl) }</FILE_LINK>
            }
        </ns1:generaEstadoCuentaTCResponse>
};

declare variable $obtenerSerializadoResponse as element(ns0:ObtenerSerializadoResponse) external;

xf:obtenerSerializadoHNOut($obtenerSerializadoResponse)
