xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)


declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetas_v2";
(:: import schema at "../../Schemas/v1/conDatoTarjetas_v2_sp.xsd" ::)
declare namespace ns0="https://www.ficohsa.com/regional/card";
(:: import schema at "../../../SBHN_Card_Commons/Schemas/CardInquiryTypes.xsd" ::)

declare namespace ns3 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDatosTC_V2";
(:: import schema at "../../Schemas/v1/consultaDatosTC_V2_sp.xsd" ::)

declare function local:consutaDatosTarjetaCreditoHNOut($DatosTarjetas_RSP as element(ns1:OutputParameters)?,
    $tipoTarjeta as xs:string?,
    $outputParameters1 as element(ns3:OutputParameters)?,$globalId as xs:string)
    as element(ns0:getCreditCardDetailsResponse) {
        <ns0:getCreditCardDetailsResponse>
         <StatusInfo>
                  <Status>Success</Status>
                  <ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</ValueDate>
                  <DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</DateTime>
                  <GlobalId>{fn:data($globalId)}</GlobalId>
              </StatusInfo>
              {
            	if(not(empty($outputParameters1/ns3:PT_DATOS_TARJETA/ns3:PT_DATOS_TARJETA_ITEM[1])))then(
	            	for $PT_DATOS_TARJETA_ITEM in $outputParameters1/ns3:PT_DATOS_TARJETA/ns3:PT_DATOS_TARJETA_ITEM
	            	return(
                            <CardNumber>{ data($PT_DATOS_TARJETA_ITEM/ns3:CARD_NUMBER) }</CardNumber>,
                            <AccountHolderName>{ data($PT_DATOS_TARJETA_ITEM/ns3:ACCOUNT_HOLDER_NAME) }</AccountHolderName>,
                            <CardHolderName>{ data($PT_DATOS_TARJETA_ITEM/ns3:CARD_HOLDER_NAME) }</CardHolderName>,
                            <CardType>{ data($PT_DATOS_TARJETA_ITEM/ns3:CARD_TYPE) }</CardType>,
                            <CustomerId>{ data($PT_DATOS_TARJETA_ITEM/ns3:CUSTOMER_ID) }</CustomerId>,
                            <CardHolderLegalId>{ data($PT_DATOS_TARJETA_ITEM/ns3:CARD_HOLDER_LEGAL_ID) }</CardHolderLegalId>,
                            <AccountHolderLegalId>{ data($PT_DATOS_TARJETA_ITEM/ns3:ACCOUNT_HOLDER_LEGAL_ID) }</AccountHolderLegalId>,
                            <AccountNumber>{ data($PT_DATOS_TARJETA_ITEM/ns3:ACCOUNT_NUMBER) }</AccountNumber>,
                            <Product>{ data($PT_DATOS_TARJETA_ITEM/ns3:PRODUCT) }</Product>,
                            <AfinityGroup>{ data($PT_DATOS_TARJETA_ITEM/ns3:AFINITY_GROUP) }</AfinityGroup>,
                            <AccountStatus>{ data($PT_DATOS_TARJETA_ITEM/ns3:ACCOUNT_STATUS) }</AccountStatus>,
   		                    <CardStatus>{ data($PT_DATOS_TARJETA_ITEM/ns3:CARD_STATUS) }</CardStatus>,
                            <CardExpirationDate>{ data($PT_DATOS_TARJETA_ITEM/ns3:CARD_EXPIRATION_DATE) }</CardExpirationDate>
	         		)
	         	)else(  
			            <CardNumber>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="numtarjeta"]) }</CardNumber>,
			            <AccountHolderName>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="account_name"]) }</AccountHolderName>,
			            <CardHolderName>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="cardholder_name"]) }</CardHolderName>,
			            <CardType>{ data($tipoTarjeta) }</CardType>,
			            <CustomerId>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="customer_id"]) }</CustomerId>,
			            <CardHolderLegalId>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="card_holder_id"]) }</CardHolderLegalId>,
			            <AccountHolderLegalId>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="account_holder_legal_id"]) }</AccountHolderLegalId>,
			            <AccountNumber>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="numcuenta"]) }</AccountNumber>,
			            <Product>TRC</Product>,
			            <AfinityGroup>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="logo"]) }</AfinityGroup>,
			            <AccountStatus>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="EstadoCuenta"]) }</AccountStatus>,
			            <CardStatus>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="EstadoPlastico"]) }</CardStatus>,
			            <CardExpirationDate>{ data($DatosTarjetas_RSP/ns1:RowSet[1]/ns1:Row[1]/ns1:Column[@name="fecexpira"]) }</CardExpirationDate>
	        	)
	        }
        </ns0:getCreditCardDetailsResponse>
};

declare variable $DatosTarjetas_RSP as element(ns1:OutputParameters)? external;
declare variable $tipoTarjeta as xs:string? external;
declare variable $outputParameters1 as element(ns3:OutputParameters)? external;
declare variable $globalId as xs:string external;

local:consutaDatosTarjetaCreditoHNOut($DatosTarjetas_RSP,
    $tipoTarjeta,
    $outputParameters1,$globalId)