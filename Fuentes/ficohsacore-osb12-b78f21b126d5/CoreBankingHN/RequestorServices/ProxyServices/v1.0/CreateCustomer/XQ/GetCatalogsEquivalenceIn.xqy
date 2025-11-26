xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCatalogsEquivalence";
(:: import schema at "../../../../../ProviderServices/XSD/GetCatalogsEquivalence/GetCatalogsEquivalence_sp.xsd" ::)

declare variable $processType as xs:string external;
declare variable $searchCriteria as xs:string external;

declare function local:func($processType as xs:string, 
                            $searchCriteria as xs:string) 
                            as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:PV_TIPO_EQ_PROCESO>{fn:data($processType)}</ns1:PV_TIPO_EQ_PROCESO>
        <ns1:PT_EQUIVALENCIAS_INGRESO>
            	{
                    let $shortCriteria := fn:tokenize($searchCriteria, '\|\|')
                    for $i in 1 to count($shortCriteria)
                    return
                         <ns1:PT_EQUIVALENCIAS_INGRESO_ITEM>
                        {
                              let $field := fn:tokenize($shortCriteria[$i], ';') 
                              return(
                                  <ns1:CATALOGO_ID>{ data($field[1]) }</ns1:CATALOGO_ID>,
                                  <ns1:VALOR_CATALOGO>{ data($field[2]) }</ns1:VALOR_CATALOGO>,
                                  <ns1:APLICACIONES>
                                  {
                                      for $j in 2 to count($field)
                                      return(
                                          if(normalize-space($field[$j+1]) != "") then (
                                              <ns1:APLICACIONES_ITEM>{data($field[$j+1])}</ns1:APLICACIONES_ITEM>
                                          )else()
                                      )
                                  }
                                  </ns1:APLICACIONES>
                              )
                          }
                          </ns1:PT_EQUIVALENCIAS_INGRESO_ITEM>
                   }
                   </ns1:PT_EQUIVALENCIAS_INGRESO>
    </ns1:InputParameters>
};

local:func($processType, $searchCriteria)
