xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/sjConsultaActivosCliente";
(:: import schema at "../XSD/sjConsultaActivosCliente.xsd" ::)
declare namespace ns2="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../../../../../SBHN_Pension_Commons/Schemas/CloudCodeTypes.xsd" ::)

declare variable $ConsultaFondoPensionesResponse as element() (:: schema-element(ns2:saldosResponse) ::) external;

declare function local:func($ConsultaFondoPensionesResponse as element() (:: schema-element(ns2:saldosResponse) ::)) as element() (:: schema-element(ns1:sjConsultaActivosClienteResponse) ::) {
    <ns1:sjConsultaActivosClienteResponse>
      <ns1:consultaFondoPensionesResponse>
        {
          if ($ConsultaFondoPensionesResponse/ns2:error = 'false')
          then <ns1:successIndicator>Success</ns1:successIndicator>
          else <ns1:successIndicator>Error</ns1:successIndicator>
        }
        {
          if($ConsultaFondoPensionesResponse/ns2:mensaje)
          then <ns1:messages>{fn:data($ConsultaFondoPensionesResponse/ns2:mensaje)}</ns1:messages>
          else()
        }
        <ns1:consultaActivoResponseRecords>
           {
                    for $CUENTA in $ConsultaFondoPensionesResponse/ns2:datos/ns2:cuentas
                    return 
                    <ns1:consultaActivoResponseRecord>
                        {
                            if ($CUENTA/ns2:cuenta)
                            then <ns1:ACCOUNTNUMBER>{fn:data($CUENTA/ns2:cuenta)}</ns1:ACCOUNTNUMBER>
                            else ()
                        }
                        {
                            let $description := concat(fn:data($CUENTA/ns2:primerNombre)," ",fn:data($CUENTA/ns2:segundoNombre)," ",fn:data($CUENTA/ns2:primerApellido)," ",
                            fn:data($CUENTA/ns2:segundoApellido))
                            return 
                            <ns1:ACCOUNTNAME>{$description}</ns1:ACCOUNTNAME>
                        }
                        {
                            if ($CUENTA/ns2:moneda)
                            then <ns1:CURRENCY>{fn:data($CUENTA/ns2:moneda)}</ns1:CURRENCY>
                            else ()
                        }
                        {
                            if ($CUENTA/ns2:saldoTotal)
                            then <ns1:TOTALBALANCE>{fn:data($CUENTA/ns2:saldoTotal)}</ns1:TOTALBALANCE>
                            else ()
                        }
                    </ns1:consultaActivoResponseRecord>
                }
        </ns1:consultaActivoResponseRecords>
      </ns1:consultaFondoPensionesResponse>
    </ns1:sjConsultaActivosClienteResponse>
};

local:func($ConsultaFondoPensionesResponse)
