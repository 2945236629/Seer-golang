package com.robot.app.mapProcess
{
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.config.ClientConfig;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MainManager;
   import com.robot.core.manager.NonoManager;
   import com.robot.core.manager.StatManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NPC;
   import com.robot.core.npc.NpcDialog;
   import flash.display.MovieClip;
   import flash.utils.getDefinitionByName;
   import org.taomee.manager.ResourceManager;
   import org.taomee.utils.DisplayUtil;
   
   public class MapProcess_1067 extends BaseMapProcess
   {
      
      public function MapProcess_1067()
      {
         super();
      }
      
      override protected function init() : void
      {
         conLevel["mazeEntry"].visible = false;
         MainManager.actorModel.hideNono();
         if(!BitBuffSetClass.getState(22669))
         {
            KTool.hideMapAllPlayerAndMonster();
            getDefinitionByName("com.robot.app2.control.DragonEvoController").setNpcVisible(false);
            ToolBarController.panel.hide();
            ToolBarController.showOrHideAllUser(false);
            LevelManager.iconLevel.visible = false;
            ResourceManager.getResource(ClientConfig.getMapAnimate("rosefinchEvoMapMC"),function(param1:MovieClip):void
            {
               var mc:MovieClip = param1;
               conLevel.addChild(mc);
               AnimateManager.playMcAnimate(mc,1,"mc",function():void
               {
                  NpcDialog.show(NPC.TWOBLONG2,["果然，他是被什么困住了！有人在神火迷阵的入口上做了手脚！"],["明白了！一定是他们！"],[function():void
                  {
                     ToolBarController.panel.hide();
                     AnimateManager.playMcAnimate(mc,2,"mc",function():void
                     {
                        NpcDialog.show(NPC.TWOBLONG2,["既然没什么好说的！那咱么就手下见真招！"],["那咱么就来吧！"],[function():void
                        {
                           ToolBarController.panel.hide();
                           AnimateManager.playMcAnimate(mc,3,"mc",function():void
                           {
                              NpcDialog.show(NPC.TIAN_XIE_LONG_WANG,["是你！你不是已经？"],["天真！"],[function():void
                              {
                                 ToolBarController.panel.hide();
                                 AnimateManager.playMcAnimate(mc,4,"mc",function():void
                                 {
                                    NpcDialog.show(NPC.TIAN_XIE_LONG_WANG,["和这么多人的战斗消耗了我太多的力量！"],["要是他恢复了力量就不好办了！"],[function():void
                                    {
                                       NpcDialog.show(NPC.TIAN_XIE_LONG_WANG,["还是走为上策，他还活着！一定要在他恢复力量前干掉探险家！要不然事情就不好办了！"],["走！"],[function():void
                                       {
                                          ToolBarController.panel.hide();
                                          AnimateManager.playMcAnimate(mc,5,"mc",function():void
                                          {
                                             StatManager.sendStat2014("朱雀超进化","看完动画的","2015运营活动");
                                             BitBuffSetClass.setState(22669,1);
                                             DisplayUtil.removeForParent(mc);
                                             LevelManager.iconLevel.visible = true;
                                             ToolBarController.panel.show();
                                             ToolBarController.showOrHideAllUser(true);
                                             getDefinitionByName("com.robot.app2.control.DragonEvoController").setNpcVisible(true);
                                             KTool.showMapAllPlayerAndMonster();
                                             getDefinitionByName("com.robot.app2.control.RosefinchEvoController").chechEntryState(conLevel["mazeEntry"]);
                                          });
                                       }]);
                                    }]);
                                 });
                              }]);
                           });
                        }]);
                     });
                  }]);
               });
            });
         }
         else
         {
            getDefinitionByName("com.robot.app2.control.DragonEvoController").setNpcVisible(true);
            getDefinitionByName("com.robot.app2.control.RosefinchEvoController").chechEntryState(conLevel["mazeEntry"]);
         }
      }
      
      override public function destroy() : void
      {
         MainManager.actorModel.showNono(NonoManager.info,MainManager.actorInfo.actionType);
      }
   }
}

