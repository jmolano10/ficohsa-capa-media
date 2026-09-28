(:: pragma bea:global-element-parameter parameter="$consultaPaquetesMovilRequest" element="ns1:consultaPaquetesMovilRequest" location="../xsd/consultaPaquetesMovilTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaRecaudoSolicitud" location="../../../BusinessServices/CTS/convenio/xsd/services.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaPaquetesTypes";
declare namespace ns0 = "http://service.srvaplcobisrecaudo.ecobis.cobiscorp";
declare namespace ns2 = "http://dto.srvaplcobisentidades.ecobis.cobiscorp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PaquetesMovil/ConsultaPaquetes/xq/consultaPaquetesMovilNIin/";

declare function xf:consultaPaquetesMovilNIin($consultaPaquetesMovilRequest as element(ns1:consultaPaquetesMovilRequest))
    as element(ns0:consultaRecaudoSolicitud)  {
         <ns0:consultaRecaudoSolicitud>
            <ns2:cobranza>NO</ns2:cobranza>
            <ns2:contractId>{ data($consultaPaquetesMovilRequest/PHONE_CARRIER) }</ns2:contractId>
            {
                for $PACK_TYPE in $consultaPaquetesMovilRequest/PACK_TYPE
                return
                    <ns2:debtorCode>{ data($PACK_TYPE) }</ns2:debtorCode>
            }
            <ns2:cobranza/>
            <ns2:currency/>
          	<ns2:billAmount/>
          	<ns2:billReturnType/>
          	<ns2:extendedCollection/>
          	<ns2:additionalInfo>
                <ns2:data></ns2:data>
            </ns2:additionalInfo>
            <ns2:contextoTransaccional>
                <ns2:identificadorTransaccional>1</ns2:identificadorTransaccional>
            </ns2:contextoTransaccional>
        </ns0:consultaRecaudoSolicitud>
};

declare variable $consultaPaquetesMovilRequest as element(ns1:consultaPaquetesMovilRequest) external;

xf:consultaPaquetesMovilNIin($consultaPaquetesMovilRequest)