xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/LineasCreditoRTNTypes";
(:: import schema at "../xsd/LineasCreditoRTNTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/LineasCreditoRTN_db";
(:: import schema at "../../../BusinessServices/ABKHN/LineasCreditoRTN/xsd/LineasCreditoRTN_db_sp.xsd" ::)

declare variable $Output as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function local:Moneda ( $item as xs:string) { 
  let $separator := 
    if (matches($item, 'DOLARES')) then 'DOLARES'
    else if (matches($item, 'LEMPIRAS')) then 'LEMPIRAS'
    else ''
  return $separator
 };
 
 declare function local:Segmento ( $item as xs:string) { 
      
      let $tokens := fn:tokenize($item, 'DOLARES|LEMPIRAS')
      return fn:normalize-space($tokens[1])
 };

declare function local:func($Output as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: schema-element(ns2:LineasCreditoRTNResponse) ::) {
     <ns2:LineasCreditoRTNResponse>
        {
            <MessageError>{fn:string(fn:data($Output/ns1:GV_MENSAJE_ERROR))}</MessageError>
        }
        {
            <CustomerId>{fn:data($Output/ns1:CODIGO_CLIENTE)}</CustomerId>
        }
        {
            <CustomerName>{fn:data($Output/ns1:NOMBRE_CLIENTE)}</CustomerName>
        }
        {
            <CustomerCreditExposure>{fn:data($Output/ns1:EXPOSICION)}</CustomerCreditExposure>
        }
       {
           if ($Output/ns1:P_RESULTADO)
           then <CreditLines>
               {
                   for $P_RESULTADO_ITEM in $Output/ns1:P_RESULTADO/ns1:P_RESULTADO_ITEM
                   return 
                   <CreditLine>
                       <CreditLineCode>{fn:string(fn:data($P_RESULTADO_ITEM/ns1:NUMERO_LINEA_CREDITO))}</CreditLineCode>
                       <CreditLineStatus>{fn:data($P_RESULTADO_ITEM/ns1:ESTADO_LINEA)}</CreditLineStatus>
                       <CreditLineDescription>{fn:data($P_RESULTADO_ITEM/ns1:DESCRIPCION_LC)}</CreditLineDescription>
                       <CreditLineValue>{fn:string(fn:data($P_RESULTADO_ITEM/ns1:EXPO))}</CreditLineValue>
                       <CurrentBalance>{fn:string(fn:data($P_RESULTADO_ITEM/ns1:MONTO_DISPONIBLE))}</CurrentBalance>
                       <AvailableAmount>{fn:string(fn:data($P_RESULTADO_ITEM/ns1:MONTO_APROBADO))}</AvailableAmount>
                       <Destination>{fn:data($P_RESULTADO_ITEM/ns1:DESTINO_CREDITO)}</Destination>
                       <ExpirationDate>{fn:string(fn:data($P_RESULTADO_ITEM/ns1:FECHA_DE_VCMTO))}</ExpirationDate>
                       <EconomicGroupCode>{fn:string(fn:data($P_RESULTADO_ITEM/ns1:CODIGO_GRUPO_EMPRESARIAL))}</EconomicGroupCode>
                       <DescriptionEconomicGroup>{fn:data($P_RESULTADO_ITEM/ns1:DESC_CODIGO_GRUPO_EMPRESARIAL)}</DescriptionEconomicGroup>
                       <DebtorsTpye>{fn:data($P_RESULTADO_ITEM/ns1:TIPO_DEUDOR_COMERCIO)}</DebtorsTpye>
                        <SegmentType>{local:Segmento(fn:data($P_RESULTADO_ITEM/ns1:DESCRIPCION_LC))}</SegmentType>
                       <CurrencyType>{local:Moneda(fn:data($P_RESULTADO_ITEM/ns1:DESCRIPCION_LC))}</CurrencyType>
                       </CreditLine>
               }</CreditLines>
           else ()
       }        
    </ns2:LineasCreditoRTNResponse>
};

local:func($Output)