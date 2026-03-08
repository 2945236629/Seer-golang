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
   import com.robot.core.utils.CommonUI;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcess_11548 extends BaseMapProcess
   {
      
      public function MapProcess_11548()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = false;
         LevelManager.toolsLevel.visible = false;
         conLevel.addEventListener(MouseEvent.CLICK,this.onConClick);
         MovieClip(conLevel).mouseChildren = MovieClip(conLevel).mouseEnabled = false;
         this.update();
      }
      
      public function update() : void
      {
         KTool.getMultiValue([101338],function(param1:Array):void
         {
            if(!BitBuffSetClass.getState(23531))
            {
               conLevel["hurtMc"].visible = false;
               conLevel["arrow_1"].visible = true;
               conLevel["arrow_2"].visible = false;
               CommonUI.setEnabled(conLevel["fight1"],false,false);
               CommonUI.setEnabled(conLevel["fight2"],false,false);
               playStory1();
            }
            else if(param1[0] >= 10000)
            {
               conLevel["hurtMc"].visible = false;
               conLevel["arrow_1"].visible = false;
               conLevel["arrow_2"].visible = true;
               playStory2();
               CommonUI.setEnabled(conLevel["fight2"],true,false);
               conLevel["fight1"].visible = false;
               CommonUI.setEnabled(conLevel["fight1"],false,false);
            }
            else
            {
               conLevel["hurtMc"].visible = true;
               conLevel["arrow_1"].visible = true;
               conLevel["arrow_2"].visible = false;
               CommonUI.setEnabled(conLevel["fight2"],false,false);
               CommonUI.setEnabled(conLevel["fight1"],true,false);
               conLevel["hurtMc"]["txt_1"].text = param1[0] + "/10000";
               conLevel["hurtMc"]["scroll"].gotoAndStop(int(param1[0] / 100));
            }
            MovieClip(conLevel).mouseChildren = MovieClip(conLevel).mouseEnabled = true;
         });
      }
      
      public function onConClick(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         switch(e.target.name)
         {
            case "fight1":
               FightManager.fightNoMapBoss("鬼藏",10929,false,true,function():void
               {
               });
               break;
            case "fight2":
               Alert.show("仔细注意接下来战斗中敌对精灵的实力！这将是救治它的关键！",function():void
               {
                  FightManager.fightNoMapBoss("闪光希莉娅",11039,false,true,function():void
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
      
      private function playStory1() : void
      {
         if(!BitBuffSetClass.getState(23531))
         {
            conLevel.mouseEnabled = conLevel.mouseChildren = true;
            NpcDialogNew_1.show(2804,["你叫吧！你就是叫破喉咙，也不会有人来救你的！"],null,null,false,function():void
            {
               NpcDialogNew_1.show(2805,["破喉咙！破喉咙！"],null,null,false,function():void
               {
                  NpcDialogNew_1.show(20,["这里有一只无辜的精灵！呀，怎么还有一只混沌教派的坏蛋！"],null,null,false,function():void
                  {
                     NpcDialogNew_1.show(2804,["哼，还真有多管闲事的蠢货冒出来，那就连你一起料理掉！"],["我可不怕你！"],[function():void
                     {
                        conLevel.mouseEnabled = conLevel.mouseChildren = true;
                        BitBuffSetClass.setState(23531,1);
                        update();
                     }]);
                  });
               });
            });
         }
      }
      
      private function playStory2() : void
      {
         if(!BitBuffSetClass.getState(23532))
         {
            conLevel.mouseEnabled = conLevel.mouseChildren = true;
            NpcDialogNew_1.show(2804,["可恶，有两下子，溜了溜了！"],null,null,false,function():void
            {
               NpcDialogNew_1.show(20,["闪光希莉娅，你还好吧？振作一点！"],null,null,false,function():void
               {
                  NpcDialogNew_1.show(2805,["我头好晕，胸好闷，感觉浑身无力……"],null,null,false,function():void
                  {
                     NpcDialogNew_1.show(20,["你先好好休息，让我来看看，你究竟是怎么了吧！"],["好……谢谢你。"],[function():void
                     {
                        conLevel.mouseEnabled = conLevel.mouseChildren = true;
                        BitBuffSetClass.setState(23532,1);
                        update();
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

