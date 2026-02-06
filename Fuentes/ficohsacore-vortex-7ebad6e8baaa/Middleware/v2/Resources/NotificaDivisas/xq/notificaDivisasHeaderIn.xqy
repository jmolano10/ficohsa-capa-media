xquery version "2004-draft";
(:: pragma  parameter="$header" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:Of_cargar_ingreso_egreso_divisas_encab" location="../../../BusinessServices/notificaDivisasEncabezado/xsd/ws_captura_piib.S_captura_piib_eco.svc.3217.xsd" ::)

declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaDivisas/xq/notificaDivisasHeaderIn/";

declare function xf:notificaDivisasHeaderIn($header as element(*),
    $user as xs:string,
    $password as xs:string,
    $entity as xs:string,
    $entrada as xs:string)
    as element(ns0:Of_cargar_ingreso_egreso_divisas_encab) {
        <ns0:Of_cargar_ingreso_egreso_divisas_encab>
            <ns0:ps_Usuario>{ $user }</ns0:ps_Usuario>
            <ns0:ps_Password>{ $password }</ns0:ps_Password>
            <ns0:ps_Entidad>{ $entity }</ns0:ps_Entidad>
            <ns0:ps_Entrada>{ concat($entrada, fn-bea:serialize($header)) }</ns0:ps_Entrada>
        </ns0:Of_cargar_ingreso_egreso_divisas_encab>
};

declare variable $header as element(*) external;
declare variable $user as xs:string external;
declare variable $password as xs:string external;
declare variable $entity as xs:string external;
declare variable $entrada as xs:string external;

xf:notificaDivisasHeaderIn($header,
    $user,
    $password,
    $entity,
    $entrada)