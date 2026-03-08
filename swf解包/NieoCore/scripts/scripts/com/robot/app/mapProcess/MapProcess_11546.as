package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NpcDialogNew_1;
   import com.robot.core.ui.alert.Alert;
   import flash.events.MouseEvent;
   
   public class MapProcess_11546 extends BaseMapProcess
   {
      
      public function MapProcess_11546()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = false;
         LevelManager.toolsLevel.visible = false;
         conLevel.addEventListener(MouseEvent.CLICK,this.onConClick);
         this.playStory();
      }
      
      public function onConClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         switch(e.target.name)
         {
            case "fight":
               Alert.show("仔细注意接下来战斗中敌对精灵的实力！这将是救治它的关键！",function():void
               {
                  FightManager.fightNoMapBoss("闪光卡基达利",10927,false,true,function():void
                  {
                     if(FightManager.isWin)
                     {
                        ModuleManager.showAppModule("AncientBattlefieldRescueTipsPanel");
                     }
                  });
               });
               break;
            case "close":
               this.destroy();
               KTool.changeMapWithCallBack(1,function():void
               {
                  ModuleManager.showAppModule("AncientBattlefieldRescueMainPanel");
               });
         }
      }
      
      private function playStory() : void
      {
         if(!BitBuffSetClass.getState(23529))
         {
            conLevel.mouseEnabled = conLevel.mouseChildren = false;
            NpcDialogNew_1.show(20,["闪光卡基达利！你怎么躺在这里！"],null,null,false,function():void
            {
               NpcDialogNew_1.show(20,["振作一点……你感觉怎么样？"],null,null,false,function():void
               {
                  NpcDialogNew_1.show(2802,["我头好晕，胸好闷，感觉浑身无力……刚才都发生了什么？"],null,null,false,function():void
                  {
                     NpcDialogNew_1.show(20,["你先好好休息，让我来看看，你究竟是怎么了吧！"],["好……谢谢你。"],[function():void
                     {
                        conLevel.mouseEnabled = conLevel.mouseChildren = true;
                        BitBuffSetClass.setState(23529,1);
                     }]);
                  });
               });
            });
         }
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.visible = true;
         LevelManager.toolsLevel.visible = true;
         if(conLevel != null)
         {
            conLevel.removeEventListener(MouseEvent.CLICK,this.onConClick);
         }
         super.destroy();
      }
   }
}

