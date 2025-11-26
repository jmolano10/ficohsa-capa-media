xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/payRemittancesTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/payRemittancesTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaRelConPagoBS";
(:: import schema at "../../../../ProviderServices/XSD/PayRemittances/ConsultaRelConPagoBS_sp.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/RegistraBitacoraRemesasGravadasBS";
(:: import schema at "../../../../ProviderServices/XSD/PayRemittances/RegistraBitacoraRemesasGravadasBS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $pagoRemesas as element() (:: schema-element(ns1:pagoRemesas) ::) external;
declare variable $outputParameters as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $remittanceType as xs:string external;
declare variable $errorMessage as xs:string external;
declare variable $agency as xs:string external;
declare variable $status as xs:string external;

declare function xq:registraBitacoraRemesasGravadasIn($ns1:pagoRemesas as element() (:: schema-element(ns1:pagoRemesas) ::), 
                                                      $outputParameters as element() (:: schema-element(ns2:OutputParameters) ::), 
                                                      $remittanceType as xs:string, 
                                                      $errorMessage as xs:string, 
                                                      $agency as xs:string, 
                                                      $status as xs:string) 
                                                      as element() (:: schema-element(ns3:InputParameters) ::) {
    <ns3:InputParameters>
            <ns3:PV_CLAVEREMESA>{ data($pagoRemesas/ns1:REMITTANCE_ID) }</ns3:PV_CLAVEREMESA>
            <ns3:PV_IDREMESADORA>{ $remittanceType }</ns3:PV_IDREMESADORA>
            {
                for $NAME in $pagoRemesas/ns1:BENEFICIARY_INFO/ns1:NAME
                return
                    <ns3:PV_NOMBREBENEFICIARIO>{ data($NAME) }</ns3:PV_NOMBREBENEFICIARIO>
            }
            <ns3:PV_IDBENEFICIARIO>{ data($pagoRemesas/ns1:BENEFICIARY_INFO/ns1:ID) }</ns3:PV_IDBENEFICIARIO>
            {
                for $PV_REMITENTE in $outputParameters/ns2:PV_REMITENTE
                return
                    <ns3:PV_NOMBREREMITENTE>{ data($PV_REMITENTE) }</ns3:PV_NOMBREREMITENTE>
            }
            {
                for $PV_MONEDA in $outputParameters/ns2:PV_MONEDA
                return
                    <ns3:PV_MONEDA>{ data($PV_MONEDA) }</ns3:PV_MONEDA>
            }
            {
                for $PN_MONTO in $outputParameters/ns2:PN_MONTO
                return
                    <ns3:PN_MONTO>{ data($PN_MONTO) }</ns3:PN_MONTO>
            }
            {
                for $PN_TASACAMBIO in $outputParameters/ns2:PN_TASACAMBIO
                return
                    <ns3:PN_TASA>{ data($PN_TASACAMBIO) }</ns3:PN_TASA>
            }
            {
                for $PN_MONTOLOCAL in $outputParameters/ns2:PN_MONTOLOCAL
                return
                    <ns3:PN_MONTOEXTRANJERO>{ data($PN_MONTOLOCAL) }</ns3:PN_MONTOEXTRANJERO>
            }
            <ns3:PV_ESTADO>{ $status }</ns3:PV_ESTADO>
            <ns3:PV_FORMAPAGO>VEN</ns3:PV_FORMAPAGO>
            {
                for $CREDIT_ACCOUNT in $pagoRemesas/ns1:CREDIT_ACCOUNT
                return
                    <ns3:PV_NUMEROCUENTA>{ data($CREDIT_ACCOUNT) }</ns3:PV_NUMEROCUENTA>
            }
            <ns3:PV_AGENCIA>{ $agency }</ns3:PV_AGENCIA>
            <ns3:PD_FECHAPAGO>{ fn:string(fn:adjust-date-to-timezone(current-date(), ())) }</ns3:PD_FECHAPAGO>
            <ns3:PV_MENSAJEERROR>{ $errorMessage }</ns3:PV_MENSAJEERROR>    
            </ns3:InputParameters>
};

xq:registraBitacoraRemesasGravadasIn($pagoRemesas, $outputParameters, $remittanceType, $errorMessage, $agency, $status)
