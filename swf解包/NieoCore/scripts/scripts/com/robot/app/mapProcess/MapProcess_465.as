package com.robot.app.mapProcess
{
   import com.robot.app.mapProcess.control.*;
   import com.robot.core.animate.*;
   import com.robot.core.config.*;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.mode.*;
   import com.robot.core.net.*;
   import flash.events.*;
   import org.taomee.manager.*;
   
   public class MapProcess_465 extends BaseMapProcess
   {
      
      private var _panel:AppModel;
      
      private var _panelHero:AppModel;
      
      public function MapProcess_465()
      {
         super();
      }
      
      override protected function init() : void
      {
         SpaceGuardController.addGuard();
         conLevel["king_door"].visible = true;
         conLevel["kingHero_door"].visible = false;
         ToolTipManager.add(conLevel["swit"],"切换模式");
         conLevel["swit"].buttonMode = true;
         conLevel["swit"].addEventListener(MouseEvent.CLICK,this.onSwitClick);
         var _temp_1:* = conLevel["mc_1"];
         conLevel["mc_1"].mouseChildren = false;
         _temp_1.mouseEnabled = false;
         var _temp_2:* = conLevel["mc_2"];
         var _loc1_:Boolean;
         conLevel["mc_2"].mouseChildren = _loc1_ = false;
         _temp_2.mouseEnabled = false;
      }
      
      private function onSwitClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(conLevel["swit"].currentFrame == 1)
         {
            conLevel["swit"].gotoAndStop(2);
            conLevel["mc_1"].visible = true;
            conLevel["mc_2"].visible = false;
            AnimateManager.playMcAnimate(conLevel["mc_1"],0,"",function():void
            {
               conLevel["king_door"].visible = false;
               conLevel["kingHero_door"].visible = true;
            });
         }
         else
         {
            conLevel["swit"].gotoAndStop(1);
            conLevel["mc_1"].visible = false;
            conLevel["mc_2"].visible = true;
            AnimateManager.playMcAnimate(conLevel["mc_2"],0,"",function():void
            {
               conLevel["king_door"].visible = true;
               conLevel["kingHero_door"].visible = false;
            });
         }
      }
      
      public function onKingDoorClick() : void
      {
         SocketConnection.send(1022,86053867);
         if(!this._panel)
         {
            this._panel = new AppModel(ClientConfig.getAppModule("KingTowerChoicePanel"),"正在加载面板");
            this._panel.setup();
         }
         this._panel.show();
         SysSOManager.freshLastSys(14007);
      }
      
      public function onKingHeroDoorClick() : void
      {
         if(!this._panelHero)
         {
            this._panelHero = new AppModel(ClientConfig.getAppModule("KingTowerHeroChoicePanel"),"正在加载面板");
            this._panelHero.setup();
         }
         this._panelHero.show();
      }
      
      override public function destroy() : void
      {
         if(Boolean(this._panel))
         {
            this._panel.destroy();
         }
         if(Boolean(this._panelHero))
         {
            this._panelHero.destroy();
         }
         ToolTipManager.remove(conLevel["swit"]);
         conLevel["swit"].removeEventListener(MouseEvent.CLICK,this.onSwitClick);
      }
   }
}

