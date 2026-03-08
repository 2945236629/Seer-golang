package com.robot.app.mapProcess
{
   import com.robot.app.panel.TopSelectPanel;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.ui.alert.Alarm;
   import flash.events.MouseEvent;
   
   public class MapProcess_1011 extends BaseMapProcess
   {
      
      public function MapProcess_1011()
      {
         super();
      }
      
      override public function destroy() : void
      {
         conLevel["btn_1"].removeEventListener(MouseEvent.CLICK,this.openMainButton);
         conLevel["btn_2"].removeEventListener(MouseEvent.CLICK,this.openMainButton);
         conLevel["btn_3"].removeEventListener(MouseEvent.CLICK,this.openMainButton);
         super.destroy();
      }
      
      override protected function init() : void
      {
         if(!BitBuffSetClass.getState(22490))
         {
            AnimateManager.playFullScreenAnimate(ClientConfig.getFullMovie("leagueFullMovie"));
            BitBuffSetClass.setState(22490,1);
         }
         StatManager.sendStat2014("巅峰之战－全国联赛","进入巅峰战场",StatManager.RUN_ACT);
         conLevel["btn_1"].addEventListener(MouseEvent.CLICK,this.openMainButton);
         conLevel["btn_2"].addEventListener(MouseEvent.CLICK,this.openMainButton);
         conLevel["btn_3"].addEventListener(MouseEvent.CLICK,this.openMainButton);
         Alarm.show("精灵太空站已消失在时空中，请前往全新的贾斯汀太空站！",function():void
         {
            MapManager.changeMap(1147);
         });
      }
      
      private function openMainButton(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         switch(e.currentTarget.name)
         {
            case "btn_1":
               TopSelectPanel.show(function():void
               {
                  TopSelectPanel.mode = TopSelectPanel.NORMAL;
                  TopSelectPanel.isPlay = true;
               });
               break;
            case "btn_2":
               ModuleManager.showModule(ClientConfig.getAppModule("LeagueNoticePanel"));
               break;
            case "btn_3":
               TopSelectPanel.show(function():void
               {
                  TopSelectPanel.mode = TopSelectPanel.BEYOND;
                  TopSelectPanel.isPlay = true;
               });
         }
      }
   }
}

