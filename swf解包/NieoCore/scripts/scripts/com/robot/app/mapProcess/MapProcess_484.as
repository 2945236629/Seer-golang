package com.robot.app.mapProcess
{
   import com.robot.app.fightNote.FightInviteManager;
   import com.robot.core.config.*;
   import com.robot.core.manager.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.net.*;
   import com.robot.core.npc.*;
   import flash.display.*;
   import flash.events.*;
   import flash.geom.*;
   
   public class MapProcess_484 extends BaseMapProcess
   {
      
      public function MapProcess_484()
      {
         super();
      }
      
      private static function npcLuLuClickHandler(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         MainManager.actorModel.moveAndAction(new Point(615,410),function():void
         {
            NpcDialog.show(NPC.LULU,["我要泡泡，我要抱抱，不要崇拜我，妹妹我只是个传说！"],["璐璐长的真可爱。"]);
         });
      }
      
      private static function kaxiusiClickHandler(param1:MouseEvent) : void
      {
         NpcDialog.show(NPC.KAXIUSI_WHITE,["守护怀特星是我的使命！"],["我要挑战你！","我先不打扰了。"],[function():void
         {
            FightInviteManager.fightWithBoss("卡修斯",0,true);
         },function():void
         {
         }]);
      }
      
      override protected function init() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:String = null;
         SocketConnection.send(1022,86071040);
         SocketConnection.send(1022,86067372);
         this.topLevel.mouseEnabled = false;
         this.topLevel.mouseChildren = false;
         conLevel["luluMC"].buttonMode = true;
         conLevel["luluMC"].addEventListener(MouseEvent.CLICK,npcLuLuClickHandler);
         _loc1_ = conLevel["kxsPP"] as MovieClip;
         _loc1_.buttonMode = true;
         _loc1_.addEventListener(MouseEvent.CLICK,this.onOpenKaXiuSiPanel);
         for(_loc2_ in animatorLevel)
         {
            if(_loc2_.indexOf("ptBoss") == -1 && _loc2_.indexOf("keMc") == -1)
            {
               animatorLevel[_loc2_].visible = false;
            }
         }
         for(_loc2_ in conLevel)
         {
            if(_loc2_.indexOf("door") == -1 && _loc2_.indexOf("keMc") == -1)
            {
               conLevel[_loc2_].visible = false;
            }
         }
         try
         {
            conLevel["kxsPP"].visible = true;
            conLevel["luluMC"].visible = true;
         }
         catch(e:Error)
         {
         }
         try
         {
            conLevel["kaxiusiMC"].visible = true;
            conLevel["kaxiusiMC"].buttonMode = true;
            conLevel["kaxiusiMC"].addEventListener(MouseEvent.CLICK,kaxiusiClickHandler);
         }
         catch(e:Error)
         {
         }
      }
      
      private function onOpenKaXiuSiPanel(param1:MouseEvent) : void
      {
         ModuleManager.showModule(ClientConfig.getAppModule("SPTKaXiuSiPanel"),"正在打开SPT卡修斯 面板");
      }
      
      override public function destroy() : void
      {
         var _loc1_:MovieClip;
         conLevel["luluMC"].removeEventListener(MouseEvent.CLICK,npcLuLuClickHandler);
         _loc1_ = conLevel["kxsPP"] as MovieClip;
         _loc1_.removeEventListener(MouseEvent.CLICK,this.onOpenKaXiuSiPanel);
         try
         {
            conLevel["kaxiusiMC"].removeEventListener(MouseEvent.CLICK,kaxiusiClickHandler);
         }
         catch(e:Error)
         {
         }
      }
   }
}

