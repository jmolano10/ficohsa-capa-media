xquery version "1.0" encoding "utf-8";

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/registraBitacoraLog";

declare variable $User as xs:string external;
declare variable $ClaveRemesa as xs:string external;
declare variable $Contrato as xs:string external;
declare variable $CodigoError  as xs:string external;
declare variable $Descripcion as xs:string external;
declare variable $RequestRecibido as xs:string external;
declare variable $RequestEnviado as xs:string external;


declare function local:func($User as xs:string,
  $ClaveRemesa  as xs:string,
  $Contrato  as xs:string,
  $CodigoError as xs:string,
  $Descripcion  as xs:string,
  $RequestRecibido  as xs:string, 
  $RequestEnviado  as xs:string)as element() {
    <ns1:InputParameters>
        <ns1:PV_USUARIO>{$User}</ns1:PV_USUARIO>
        <ns1:PV_CLAVE_REMESA>{$ClaveRemesa}</ns1:PV_CLAVE_REMESA>
        <ns1:PV_NUMERO_CONTRATO>{$Contrato}</ns1:PV_NUMERO_CONTRATO>
        <ns1:PV_CODIGO_ERROR>{$CodigoError}</ns1:PV_CODIGO_ERROR>
        <ns1:PV_DESCRIPCION>{$Descripcion}</ns1:PV_DESCRIPCION>
        <ns1:PC_REQUEST_RECIBIDO>{$RequestRecibido}</ns1:PC_REQUEST_RECIBIDO>
        <ns1:PC_REQUEST_ENVIADO>{$RequestEnviado}</ns1:PC_REQUEST_ENVIADO>
        
    </ns1:InputParameters>
};

local:func($User,$ClaveRemesa,$Contrato,$CodigoError,$Descripcion, $RequestRecibido,$RequestEnviado)